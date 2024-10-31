package com.labbd;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

public class PostgresProcessor {
    private final HikariDataSource dataSource;

    public PostgresProcessor(String jdbcUrl, String username, String password) {
        HikariConfig config = new HikariConfig();
        config.setJdbcUrl(jdbcUrl);
        config.setUsername(username);
        config.setPassword(password);
        config.setMaximumPoolSize(10); // Set the pool size based on your requirements
        this.dataSource = new HikariDataSource(config);
        createTableIfNotExists();
    }

    private void createTableIfNotExists() {
        String createTableSQL = "CREATE TABLE IF NOT EXISTS sensor_data (" +
                "id SERIAL PRIMARY KEY," +
                "device_id VARCHAR(255) NOT NULL," +
                "timestamp TIMESTAMP NOT NULL," +
                "temperature FLOAT NOT NULL," +
                "humidity FLOAT NOT NULL," +
                "latitude FLOAT NOT NULL," +
                "longitude FLOAT NOT NULL" +
                ");";

        try (Connection connection = dataSource.getConnection();
             Statement stmt = connection.createStatement()) {
            stmt.execute(createTableSQL);
            System.out.println("Table sensor_data created or already exists.");
        } catch (SQLException e) {
            System.err.println("Error creating table: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void saveToDatabase(String jsonData) {
    try (Connection connection = dataSource.getConnection()) {
        // Parse the JSON data
        ObjectMapper mapper = new ObjectMapper();
        JsonNode jsonNode = mapper.readTree(jsonData);
        
        // Extract values from JSON
        String deviceId = jsonNode.get("deviceId").asText();
        String timestamp = jsonNode.get("timestamp").asText().replace('T', ' '); // Replace 'T' with space
        float temperature = (float) jsonNode.get("temperature").asDouble();
        float humidity = (float) jsonNode.get("humidity").asDouble();
        float latitude = (float) jsonNode.get("location").get("latitude").asDouble();
        float longitude = (float) jsonNode.get("location").get("longitude").asDouble();

        // Prepare the insert statement
        String insertSQL = "INSERT INTO sensor_data (device_id, timestamp, temperature, humidity, latitude, longitude) " +
                "VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement preparedStatement = connection.prepareStatement(insertSQL)) {
            preparedStatement.setString(1, deviceId);
            preparedStatement.setTimestamp(2, Timestamp.valueOf(timestamp));
            preparedStatement.setFloat(3, temperature);
            preparedStatement.setFloat(4, humidity);
            preparedStatement.setFloat(5, latitude);
            preparedStatement.setFloat(6, longitude);
            preparedStatement.executeUpdate();
            System.out.println("Saved to database: " + jsonData); // Debug log
        }
    } catch (SQLException e) {
        System.err.println("Error saving to database: " + e.getMessage());
        e.printStackTrace(); // Log the stack trace for detailed debugging
    } catch (IOException e) {
        System.err.println("Error parsing JSON data: " + e.getMessage());
        e.printStackTrace();
    }
}

}
