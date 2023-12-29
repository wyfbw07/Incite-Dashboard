//
//  Details.swift
//  Incite Dash
//
//  Created by Yifan Wang on 12/29/23.
//

import SwiftUI

struct DetailsView: View {
    let device: Device

    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(try! AttributedString(markdown: device.id))
                .font(.headline)
            .font(.caption)
            .foregroundColor(.orange)
        }
    }
}

#Preview {
    DetailsView(device: .preview[0])
}
