//
//  HomeView.swift
//  RentACar
//
//  Created by Gavin Li on 1/5/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("🏠 Welcome to Home")
                    .font(.largeTitle)
                    .padding()

                Text("Find your perfect rental car!")
                    .font(.title2)
            }
            .navigationTitle("HomePage")
        }
    }
}

#Preview {
    HomeView()
}
