//
//  ExploreView.swift
//  RentACar
//
//  Created by Gavin Li on 1/5/2025.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("🔎 Explore Cars")
                    .font(.largeTitle)
                    .padding()

                Text("Browse our car collection")
                    .font(.title2)
            }
            .navigationTitle("ExplorePage")
        }
    }
}

#Preview {
    ExploreView()
}

