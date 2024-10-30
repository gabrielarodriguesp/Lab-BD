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

    public PostgresProcessor(BlockingQueue<SensorData> queue) {
        this.queue = queue;
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
            }

            String sql = "INSERT INTO sensor_data (device_id, temperature, timestamp) VALUES (?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                while (true) {
                    SensorData data = queue.take(); // Blocking call
                    preparedStatement.setString(1, data.getDeviceId());
                    preparedStatement.setDouble(2, data.getTemperature());

                    // Convert timestamp string from ISO 8601 format to Timestamp
                    String timestampStr = data.getTimestamp();
                    // Parse the timestamp
                    SimpleDateFormat isoFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
                    Date parsedDate = isoFormat.parse(timestampStr);
                    Timestamp timestamp = new Timestamp(parsedDate.getTime()); // Convert to Timestamp

                    preparedStatement.setTimestamp(3, timestamp);
                    preparedStatement.executeUpdate();
                    System.out.println("Inserted into PostgreSQL: " + data);
                }
            }
        } catch (SQLException | InterruptedException | java.text.ParseException e) {
            e.printStackTrace();
        }
    }
}
