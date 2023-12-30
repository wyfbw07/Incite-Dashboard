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
        
        GeometryReader { geometry in
            ScrollView{
                let width: CGFloat = GridItemConstants.width
                LazyVGrid(columns: [adaptiveGridItem(width: width)], spacing: 0) {
                    ForEach(model.devices) { item in
                        NavigationLink(destination: DetailsView(device: item)) {
                            GridItemView(device: item)
                                .aspectRatio(GridItemConstants.aspectRatio, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay( // apply a rounded border
                                    RoundedRectangle(cornerRadius: 15)
                                        .inset(by: 1)
                                        .stroke(.blue, lineWidth: 1)
                                )
                        }
                    }.padding(5)
                }
                .padding(.top, 5)
                .padding(.horizontal, 5)
                .padding(.bottom, 50)
            }
            .onAppear {
                model.fetchProjectsData() // Fetch data when the view appears
            }
            .refreshable { model.fetchProjectsData() }
            .navigationDestination(for: Device.self) { device in
                DetailsView(device: device)
            }
            .navigationTitle("Device List")
        }
        
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var gridItem = GridItem(.adaptive(minimum: width))
        gridItem.spacing = 0
        return gridItem
    }
    
    private struct GridItemConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let width: CGFloat = 150
        static let height: CGFloat = width/aspectRatio
    }
}

#Preview {
    DashboardView()
}
