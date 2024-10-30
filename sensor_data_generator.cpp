#include <iostream>
#include <fstream> // Make sure this is included for std::ofstream
#include <thread>
#include <vector>
#include <random>
#include <chrono>
#include <mutex>
#include <string>
#include <iomanip>
#include <ctime>

std::mutex file_mutex;

std::string generate_timestamp() {
    std::time_t now = std::time(nullptr);
    std::tm *timeinfo = std::localtime(&now);
    std::ostringstream oss;
    oss << std::put_time(timeinfo, "%Y-%m-%dT%H:%M:%S");
    return oss.str();
}

void generate_sensor_data(int thread_id, int num_entries, const std::string& filename) {
    std::ofstream ofs;
    ofs.open(filename, std::ios::app); // Open in append mode
    if (!ofs.is_open()) {
        std::cerr << "Could not open the file!" << std::endl;
        return;
    }

    // Start the JSON array
    {
        std::lock_guard<std::mutex> guard(file_mutex);
        if (ofs.tellp() == 0) { // Check if the file is empty
            ofs << "["; // Write the opening bracket for the array
        } else {
            ofs << ","; // Write a comma before the new entries if the file is not empty
        }
    }

    std::default_random_engine generator(std::chrono::system_clock::now().time_since_epoch().count() + thread_id);
    std::uniform_real_distribution<double> temperature_distribution(-20.0, 50.0);
    std::uniform_real_distribution<double> humidity_distribution(0.0, 100.0);
    std::uniform_int_distribution<int> device_id_distribution(0, 999);
    std::uniform_real_distribution<double> latitude_distribution(-90.0, 90.0);
    std::uniform_real_distribution<double> longitude_distribution(-180.0, 180.0);

    for (int i = 0; i < num_entries; ++i) {
        std::string device_id = "sensor_" + std::to_string(device_id_distribution(generator));
        std::string timestamp = generate_timestamp();
        double temperature = temperature_distribution(generator);
        double humidity = humidity_distribution(generator);
        double latitude = latitude_distribution(generator);
        double longitude = longitude_distribution(generator);

        // Locking to ensure thread safety while writing to the file
        {
            std::lock_guard<std::mutex> guard(file_mutex);
            ofs << "{\"deviceId\": \"" << device_id << "\", "
                << "\"timestamp\": \"" << timestamp << "\", "
                << "\"temperature\": " << round(temperature * 100.0) / 100.0 << ", "
                << "\"humidity\": " << round(humidity * 100.0) / 100.0 << ", "
                << "\"location\": {"
                << "\"latitude\": " << round(latitude * 1000000.0) / 1000000.0 << ", "
                << "\"longitude\": " << round(longitude * 1000000.0) / 1000000.0 
                << "}}";
        }
    }

    // Locking to ensure thread safety while closing the array
    {
        std::lock_guard<std::mutex> guard(file_mutex);
        ofs << std::endl; // Optional: Add a newline for readability
    }

    ofs.close();
}

int main() {
    const int num_threads = 4;      // Number of threads
    const int num_entries = 2500;   // Number of entries per thread
    const std::string filename = "sensor_data.json";

    // Generate sensor data in separate threads
    std::vector<std::thread> threads;
    for (int i = 0; i < num_threads; ++i) {
        threads.emplace_back(generate_sensor_data, i, num_entries, filename);
    }

    // Join all threads
    for (auto& thread : threads) {
        thread.join();
    }

    // Close the JSON array in the main thread
    {
        std::lock_guard<std::mutex> guard(file_mutex);
        std::ofstream ofs(filename, std::ios::app); // Open again to close the array
        if (ofs.is_open()) {
            ofs << "]"; // Write the closing bracket for the array
        }
    }

    std::cout << "Sensor data generation completed." << std::endl; // Ensure std::cout is properly referenced
    return 0;
}
