//
//  DashboardViewModel.swift
//  Incite Dash
//
//  Created by Yifan Wang on 12/28/23.
//


import Foundation

extension DashboardView {
    
    class Model: ObservableObject {
        @Published private(set) var devices: [Device] = []
        @Published private(set) var project: ApiResponse?
        
        func fetchProjectsData() {
            fetchData { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let jsonObject):
                        self.project = jsonObject
                        self.devices = jsonObject.devices
                    case .failure(let error):
                        print("Error: \(error)")
                        // Handle the error
                    }
                }
            }
        }
    }
}
