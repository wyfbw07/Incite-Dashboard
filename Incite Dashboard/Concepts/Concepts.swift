//
//  Concepts.swift
//  Incite Dashboard
//
//  Created by Yifan Wang on 12/28/23.
//

import Foundation

// Define Codable structs to represent the data structure

struct ApiResponse: Codable {
    let devices: [Device]
    let nextPageToken: String
}

struct Device: Identifiable, Hashable {
    let id: String
    let type: String
    let productNumber: String
    let labels: Labels
    let reported: Reported
}

extension Device: Codable {
    enum CodingKeys: String, CodingKey {
        case id = "name"
        case type, productNumber, labels, reported
    }
}

struct Labels: Hashable, Codable {
    let kit: String
    let name: String
}

struct Reported: Hashable, Codable {
    let networkStatus: NetworkStatus?
    let batteryStatus: BatteryStatus?
    let humidity: Humidity?
    let touch: Touch?
    // Add other properties as needed
}

// Define CloudConnector struct
struct CloudConnector: Hashable, Codable {
    let id: String
    let signalStrength: Int
    let rssi: Int
}

// Define NetworkStatus struct
struct NetworkStatus: Hashable, Codable {
    let signalStrength: Int
    let rssi: Int
    let updateTime: String
    let cloudConnectors: [CloudConnector]?
    let transmissionMode: String
}

// Define BatteryStatus struct
struct BatteryStatus: Hashable, Codable {
    let percentage: Int
    let updateTime: String
}

// Define Humidity struct
struct Humidity: Hashable, Codable {
    let temperature: Double
    let relativeHumidity: Double
    let updateTime: String
}

// Define Touch struct
struct Touch: Hashable, Codable {
    let updateTime: String
}
