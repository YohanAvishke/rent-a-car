//
//  ExploreView.swift
//  RentACar
//
//  Created by Gavin Li on 1/5/2025.
//

import SwiftUI

struct ExploreView: View {
    @State private var searchText: String = ""
    @State private var selectedFilter: String? = nil

    struct Car: Identifiable {
        let id = UUID()
        let name: String
        let location: String
        let pricePerDay: Int
        let brand: String
        let imageName: String
    }

    let cars: [Car] = [
        Car(name: "Mitsubishi OUTLANDER 2023", location: "Chippendale • 2.3 km", pricePerDay: 186, brand: "Mitsubishi", imageName: "car1"),
        Car(name: "Tesla Model 3 2022", location: "Sydney • 1.5 km", pricePerDay: 220, brand: "Tesla", imageName: "car2"),
        Car(name: "BMW X5 2021", location: "Parramatta • 5 km", pricePerDay: 250, brand: "BMW", imageName: "car3")
    ]

    let filters = ["All", "Mitsubishi", "Tesla", "BMW", "Price < 200"]

    var filteredCars: [Car] {
        cars.filter { car in
            let matchesSearch = searchText.isEmpty || car.name.localizedCaseInsensitiveContains(searchText)
            let matchesFilter: Bool
            if let filter = selectedFilter {
                switch filter {
                case "Mitsubishi":
                    matchesFilter = car.brand == "Mitsubishi"
                case "Tesla":
                    matchesFilter = car.brand == "Tesla"
                case "BMW":
                    matchesFilter = car.brand == "BMW"
                case "Price < 200":
                    matchesFilter = car.pricePerDay < 200
                case "All":
                    matchesFilter = true
                default:
                    matchesFilter = true
                }
            } else {
                matchesFilter = true
            }
            return matchesSearch && matchesFilter
        }
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {

                // 搜索框
                TextField("Search cars...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                // 过滤器按钮
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(filters, id: \.self) { filter in
                            Button(action: {
                                selectedFilter = filter
                            }) {
                                Text(filter)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(selectedFilter == filter ? Color.blue : Color(.systemGray6))
                                    .foregroundColor(selectedFilter == filter ? .white : .black)
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 8)

                // 汽车列表
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(filteredCars) { car in
                            CarCardView(car: car)
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .navigationTitle("Explore")
        }
    }
}

struct CarCardView: View {
    let car: ExploreView.Car

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(car.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .cornerRadius(12)

            Text(car.name)
                .font(.headline)

            Text(car.location)
                .font(.subheadline)
                .foregroundColor(.secondary)

            Text("$\(car.pricePerDay)/day")
                .font(.title3)
                .bold()

        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

#Preview {
    ExploreView()
}

