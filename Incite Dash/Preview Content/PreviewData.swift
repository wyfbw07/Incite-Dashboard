//
//  PreviewData.swift
//  Incite Dashboard
//
//  Created by Yifan Wang on 12/28/23.
//

import Foundation

extension Device {
    static var preview: [Device] {
        guard let url = Bundle.main.url(forResource: "PreviewData", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            fatalError("Unable to load PreviewData.json")
        }

        do {
            let response = try JSONDecoder().decode(ApiResponse.self, from: data)
            return response.devices
        } catch {
            fatalError("Unable to decode JSON: \(error)")
        }
    }
}
