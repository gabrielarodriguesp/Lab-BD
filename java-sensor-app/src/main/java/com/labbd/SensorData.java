package com.labbd;

import java.time.LocalDateTime;

public class SensorData {
    private String deviceId;
    private double temperature;
    private String timestamp;
    private double humidity;
    private Location location;

    // Construtores
    public SensorData() {
    }

    public SensorData(String deviceId, double temperature, String timestamp, double humidity, Location location) {
        this.deviceId = deviceId;
        this.temperature = temperature;
        this.timestamp = timestamp;
        this.humidity = humidity;
        this.location = location;
    }

    // Getters e Setters
    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public double getTemperature() {
        return temperature;
    }

    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public double getHumidity() {
        return humidity;
    }

    public void setHumidity(double humidity) {
        this.humidity = humidity;
    }

    public Location getLocation() {
        return location;
    }

    public void setLocation(Location location) {
        this.location = location;
    }

    @Override
    public String toString() {
        return String.format(
            "SensorData {deviceId='%s', temperature=%.2f, timestamp='%s', humidity=%.2f, location=%s}",
            deviceId, temperature, timestamp, humidity, location);
    }
}

class Location {
    private double latitude;
    private double longitude;

    // Construtores
    public Location() {
    }

    public Location(double latitude, double longitude) {
        setLatitude(latitude);
        setLongitude(longitude);
    }

    // Getters e Setters
    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        if (latitude < -90 || latitude > 90) {
            throw new IllegalArgumentException("Latitude must be between -90 and 90 degrees.");
        }
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        if (longitude < -180 || longitude > 180) {
            throw new IllegalArgumentException("Longitude must be between -180 and 180 degrees.");
        }
        this.longitude = longitude;
    }

    @Override
    public String toString() {
        return String.format("Location {latitude=%.6f, longitude=%.6f}", latitude, longitude);
    }
}
