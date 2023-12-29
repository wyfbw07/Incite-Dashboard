//
//  DashboardView.swift
//  Incite Dash
//
//  Created by Yifan Wang on 12/28/23.
//

import SwiftUI

struct DashboardView: View {
    @StateObject var model = Model()
    
    var body: some View {
        List(model.devices) { device in
            NavigationLink(value: device) {
                
                DetailsView(device: device)
                    .alignmentGuide(.listRowSeparatorLeading) { d in d[.leading] }
            }
        }
        .listStyle(.plain)
        .listRowInsets(.none)
        .navigationTitle("Device List")
        .onAppear {
            model.fetchProjectsData() // Fetch data when the view appears
        }
        .refreshable { model.fetchProjectsData() }
        .navigationDestination(for: Device.self) { device in
            DetailsView(device: device)
        }
    }
}


#Preview {
    DashboardView()
}
