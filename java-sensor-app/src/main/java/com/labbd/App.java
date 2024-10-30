package com.labbd;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

public class App {

    public static void main(String[] args) {
        System.out.println("Starting IoT Data Processor...");

        // Check if JSON file is loaded correctly
        String jsonFilePath = "../sensor_data.json"; // Update this path as needed
        File jsonFile = new File(jsonFilePath);

        if (!jsonFile.exists()) {
            System.err.println("Error: JSON file not found at " + jsonFilePath);
            return; // Exit if file not found
        }

        // Create a blocking queue for sensor data
        BlockingQueue<SensorData> queue = new ArrayBlockingQueue<>(1000); // Adjust size as needed

        // Start the Redis and PostgreSQL processors
    RedisProcessor redisProcessor = new RedisProcessor(queue);
    PostgresProcessor postgresProcessor = new PostgresProcessor(queue);

    Thread redisThread = new Thread(redisProcessor);
    Thread postgresThread = new Thread(postgresProcessor);

    redisThread.start();
    postgresThread.start();

    // Read and print the JSON file content
    try {
        ObjectMapper objectMapper = new ObjectMapper();
        List<SensorData> sensorDataList = objectMapper.readValue(jsonFile, objectMapper.getTypeFactory().constructCollectionType(List.class, SensorData.class));
        
        // Add sensor data to the queue
        for (SensorData data : sensorDataList) {
            queue.put(data);
            System.out.println("Queued sensor data: " + data);
        }

        // Finalize o processador Redis
        redisProcessor.stop();
        // Finalize o processador PostgreSQL
        postgresProcessor.stop();

    } catch (IOException | InterruptedException e) {
        System.err.println("Error processing the JSON file: " + e.getMessage());
        e.printStackTrace();
    }

    // Wait for the processors to finish (optional, depends on your logic)
    try {
        redisThread.join();
        postgresThread.join();
    } catch (InterruptedException e) {
        e.printStackTrace();
    }

    System.out.println("Data processing completed.");

    }
}