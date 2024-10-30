package com.labbd;

public class SensorData {
    private String deviceId;  // Change "device_id" to "deviceId"
    private double temperature;
    private String timestamp;
    private double humidity;  // Add humidity field
    private Location location; // Add location object

    // Constructors
    public SensorData() {
    }

    public SensorData(String deviceId, double temperature, String timestamp, double humidity, Location location) {
        this.deviceId = deviceId;
        this.temperature = temperature;
        this.timestamp = timestamp;
        this.humidity = humidity;
        this.location = location;
    }

    // Getters and Setters
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
}

class Location {
    private double latitude;
    private double longitude;

    // Constructors
    public Location() {
    }

    public Location(double latitude, double longitude) {
        this.latitude = latitude;
        this.longitude = longitude;
    }

    // Getters and Setters
    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
}
