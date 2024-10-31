package com.labbd;

import redis.clients.jedis.Jedis;

public class RedisProcessor implements Runnable {
    private final Jedis redisClient;
    private final PostgresProcessor postgresProcessor;

    public RedisProcessor(Jedis redisClient, PostgresProcessor postgresProcessor) {
        this.redisClient = redisClient;
        this.postgresProcessor = postgresProcessor;
    }

    @Override
    public void run() {
        while (true) {
            try {
                String jsonData = redisClient.rpop("sensorQueue");
                if (jsonData != null) {
                    System.out.println("Processing JSON Data: " + jsonData); // Debug log
                    postgresProcessor.saveToDatabase(jsonData);
                } else {
                    System.out.println("No more data in the queue."); // Debug log
                    break; // Exit when Redis queue is empty
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
