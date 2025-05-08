//
//  LikedVehiclesView.swift
//  RentACar
//
//  Created by Gavin Li on 5/8/2025.
//

import SwiftUI

struct LikedVehiclesView: View {
    // 示例喜欢的车辆
    let likedVehicles = [
        LikedVehicle(id: "1", name: "Tesla Model 3", location: "Sydney", pricePerDay: 220, imageName: "car2"),
        LikedVehicle(id: "2", name: "BMW X5", location: "Parramatta", pricePerDay: 250, imageName: "car3")
    ]
    
    var body: some View {
        List {
            ForEach(likedVehicles) { vehicle in
                LikedVehicleItemView(vehicle: vehicle)
            }
        }
        .navigationTitle("Liked Vehicles")
        .listStyle(InsetGroupedListStyle())
    }
}

struct LikedVehicle: Identifiable {
    let id: String
    let name: String
    let location: String
    let pricePerDay: Int
    let imageName: String
}

struct LikedVehicleItemView: View {
    let vehicle: LikedVehicle
    @State private var isLiked = true
    
    var body: some View {
        HStack(spacing: 16) {
            Image(vehicle.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(vehicle.name)
                    .font(.headline)
                
                Text(vehicle.location)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("$\(vehicle.pricePerDay)/Day")
                    .font(.subheadline)
            }
            
            Spacer()
            
            Button(action: {
                isLiked.toggle()
            }) {
                Image(systemName: isLiked ? "heart.fill" : "heart")
                    .foregroundColor(isLiked ? .red : .gray)
                    .imageScale(.large)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    NavigationView {
        LikedVehiclesView()
    }
}
