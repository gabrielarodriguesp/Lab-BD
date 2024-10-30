package com.labbd;

import redis.clients.jedis.Jedis;

import java.util.concurrent.BlockingQueue;

public class RedisProcessor implements Runnable {
    private final BlockingQueue<SensorData> queue;

    public RedisProcessor(BlockingQueue<SensorData> queue) {
        this.queue = queue;
    }

    @Override
    public void run() {
        try (Jedis jedis = new Jedis("redis")) {
            System.out.println("Connected to Redis");

            while (true) {
                SensorData data = queue.take(); // Blocking call
                // Push data to Redis as JSON string
                jedis.lpush("sensor_data", String.format(
                    "{\"device_id\": \"%s\", \"temperature\": %.2f, \"timestamp\": \"%s\"}",
                    data.getDeviceId(), data.getTemperature(), data.getTimestamp()));
                System.out.println("Pushed to Redis: " + data);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
