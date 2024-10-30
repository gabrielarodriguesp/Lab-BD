package com.labbd;

import redis.clients.jedis.Jedis;
import java.util.concurrent.BlockingQueue;

public class RedisProcessor implements Runnable {
    private final BlockingQueue<SensorData> queue;
    private volatile boolean running = true; // Flag de controle

    public RedisProcessor(BlockingQueue<SensorData> queue) {
        this.queue = queue;
    }

    public void stop() {
        running = false; // Define a flag para encerrar o loop
    }

    @Override
    public void run() {
        try (Jedis jedis = new Jedis("redis")) {
            System.out.println("Connected to Redis");

            while (running) { // O loop agora depende da flag running
                SensorData data = queue.take(); // Blocking call

                if (data != null) { // Verifica se o dado não é nulo antes de inserir
                    // Push data to Redis as JSON string
                    jedis.lpush("sensor_data", String.format(
                        "{\"device_id\": \"%s\", \"temperature\": %.2f, \"timestamp\": \"%s\"}",
                        data.getDeviceId(), data.getTemperature(), data.getTimestamp()));
                    System.out.println("Pushed to Redis: " + data);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}