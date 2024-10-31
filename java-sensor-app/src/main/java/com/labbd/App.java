package com.labbd;

import redis.clients.jedis.Jedis;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class App {
    public static void main(String[] args) {
        String filePath = "../sensor_data.json";
        ExecutorService executor = Executors.newFixedThreadPool(2);

        try (Jedis redisClient = new Jedis("redis", 6379);
             Connection postgresConnection = DriverManager.getConnection(
                     "jdbc:postgresql://postgres:5432/iot_data", "user", "password")) {

            PostgresProcessor postgresProcessor = new PostgresProcessor(
                "jdbc:postgresql://postgres:5432/iot_data", "user", "password");
            JsonReader jsonReader = new JsonReader(filePath, redisClient);
            RedisProcessor redisProcessor = new RedisProcessor(redisClient, postgresProcessor);

            executor.execute(jsonReader);
            executor.execute(redisProcessor);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            executor.shutdown();
        }
    }
}