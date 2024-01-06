//
//  GridItemView.swift
//  Incite Dash
//
//  Created by Yifan Wang on 12/28/23.
//

import SwiftUI

struct GridItemView: View {
    
    let device: Device
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading) {
                    Text(device.labels.name)
                        .font(Font.system(size: DrawingConstants.deviceLabelFontSize))
                        .foregroundColor(.primary)
                    if let (readings, readingTitles) = getDeviceNumberReadings(device: device) {
                        ForEach(0..<readings.count, id: \.self) { index in
                            Text(String(readings[index]))
                                .padding(.top, 5)
                                .font(Font.system(size: DrawingConstants.readingFontSize))
                            Text(readingTitles[index])
                                .font(Font.system(size: DrawingConstants.readingTitleFontSize))
                        }
                    }
                    if let (readings, readingTitles) = getDeviceDescriptiveReadings(device: device) {
                        ForEach(0..<readings.count, id: \.self) { index in
                            Text(String(readings[index]))
                                .padding(.top, 5)
                                .font(Font.system(size: DrawingConstants.readingFontSize))
                            Text(readingTitles[index])
                                .font(Font.system(size: DrawingConstants.readingTitleFontSize))
                        }
                    }
                }
            }
        }
        .padding(12)
        .multilineTextAlignment(.leading)
        .foregroundColor(.primary)
        .padding(DrawingConstants.circlePadding)
        .background(Color(.systemFill))
    }
    
    private func getDeviceNumberReadings(device: Device) -> ([Double], [String])? {
        var readings = [Double]()
        var readingTitles = [String]()
        
        // Device specific readings
        switch device.type {
        case "temperature":
            if let temperature = device.reported.temperature?.value {
                readings.append(temperature)
                readingTitles.append("Temperature (C)")
            }
        case "humidity":
            if let humidity = device.reported.humidity?.relativeHumidity {
                readings.append(humidity)
                readingTitles.append("Humidity")
            }
        default:
            break
        }
        
        if (device.reported.networkStatus != nil) {
            if let signalStrength = device.reported.networkStatus?.signalStrength {
                readings.append(Double(signalStrength))
                readingTitles.append("Signal Strength")
            }
        }
        if (device.reported.batteryStatus != nil) {
            if let percentage = device.reported.batteryStatus?.percentage {
                readings.append(Double(percentage))
                readingTitles.append("Battery Percentage")
            }
        }
        
        return (readings, readingTitles)
    }
    
    private func getDeviceDescriptiveReadings(device: Device) -> ([String], [String])? {
        var readings = [String]()
        var readingTitles = [String]()
        
        readings.append(device.productNumber)
        readingTitles.append("Product Number")
        
        return (readings, readingTitles)
    }
    
    private struct DrawingConstants {
        static let fontScale: CGFloat = 0.7
        static let deviceLabelFontSize: CGFloat = 17
        static let readingTitleFontSize: CGFloat = 12
        static let readingFontSize: CGFloat = 17
        static let circlePadding: CGFloat = 5
    }
}

#Preview {
    GridItemView(device: .preview[3])
}
