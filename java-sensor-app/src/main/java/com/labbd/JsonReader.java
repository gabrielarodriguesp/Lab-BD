package com.labbd;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import redis.clients.jedis.Jedis;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;

public class JsonReader implements Runnable {
    private final Jedis redisClient;
    private final String filePath;

    public JsonReader(String filePath, Jedis redisClient) {
        this.filePath = filePath;
        this.redisClient = redisClient;
    }

    @Override
    public void run() {
        ObjectMapper mapper = new ObjectMapper();
        try {
            JsonNode rootNode = mapper.readTree(new File(filePath));
            Iterator<JsonNode> elements = rootNode.elements();
            while (elements.hasNext()) {
                JsonNode sensorData = elements.next();
                String jsonData = sensorData.toString();
                // Push JSON string to Redis
                redisClient.lpush("sensorQueue", jsonData);
                System.out.println("Pushed to Redis: " + jsonData); 
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            redisClient.close(); // Close Redis client after reading
        }
    }
}