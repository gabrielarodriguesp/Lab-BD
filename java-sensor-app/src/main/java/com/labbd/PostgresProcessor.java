package com.labbd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.concurrent.BlockingQueue;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

public class PostgresProcessor implements Runnable {
    private final BlockingQueue<SensorData> queue;
    private static String db = "iot_data";
    private static String username = "user";
    private static String password = "password";
    private volatile boolean running = true; // Flag de controle

    public PostgresProcessor(BlockingQueue<SensorData> queue) {
        this.queue = queue;
    }

    public void stop() {
        running = false; // Define a flag para encerrar o loop
    }

    @Override
    public void run() {
        try (Connection connection = DriverManager.getConnection("jdbc:postgresql://postgres:5432/" + db, username, password)) {
            System.out.println("Connected to PostgreSQL");

            // Create table if it doesn't exist
            String createTableSQL = "CREATE TABLE IF NOT EXISTS sensor_data (" +
                                    "device_id VARCHAR(50)," +
                                    "temperature DOUBLE PRECISION," +
                                    "timestamp TIMESTAMP WITHOUT TIME ZONE" +
                                    ")";
            try (Statement statement = connection.createStatement()) {
                statement.execute(createTableSQL);
                System.out.println("Sensor data table checked/created.");
            } catch (SQLException e) {
                System.err.println("Error creating table: " + e.getMessage());
                e.printStackTrace();
                return; // Saia do método se a tabela não puder ser criada
            }

            String sql = "INSERT INTO sensor_data (device_id, temperature, timestamp) VALUES (?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                while (running) { // O loop agora depende da flag running
                    SensorData data = queue.take(); // Blocking call

                    if (data != null) { // Verifica se o dado não é nulo antes de inserir
                        preparedStatement.setString(1, data.getDeviceId());
                        preparedStatement.setDouble(2, data.getTemperature());

                        // Converte a string timestamp para o formato Timestamp do PostgreSQL
                        String timestampStr = data.getTimestamp();
                        SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");

                        // Adicione um log para mostrar o timestamp antes da conversão
                        System.out.println("Timestamp before parsing: " + timestampStr);

                        Date parsedDate = isoFormat.parse(timestampStr);
                        Timestamp timestamp = new Timestamp(parsedDate.getTime());

                        preparedStatement.setTimestamp(3, timestamp);

                        // Execute a inserção e capture o número de linhas afetadas
                        int affectedRows = preparedStatement.executeUpdate();
                        System.out.println("Inserted into PostgreSQL: " + data + " (Rows affected: " + affectedRows + ")");
                    } else {
                        System.err.println("Received null data, skipping insertion.");
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
            e.printStackTrace();
        } catch (InterruptedException e) {
            System.err.println("Thread interrupted: " + e.getMessage());
            e.printStackTrace();
        } catch (java.text.ParseException e) {
            System.err.println("Error parsing timestamp: " + e.getMessage());
            e.printStackTrace();
        }
    }


}