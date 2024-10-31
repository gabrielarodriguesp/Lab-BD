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
                    System.out.println("Processing JSON Data: " + jsonData); // Log para verificar se os dados estão sendo processados
                    postgresProcessor.saveToDatabase(jsonData);
                    System.out.println("Processed and attempted to save to database."); // Log para confirmar a tentativa de salvamento
                } else {
                    System.out.println("No more data in the queue."); // Mensagem se a fila estiver vazia
                    break; // Sai do loop quando a fila do Redis estiver vazia
                }
            } catch (Exception e) {
                e.printStackTrace(); // Log para capturar qualquer exceção
            }
        }
    }


}