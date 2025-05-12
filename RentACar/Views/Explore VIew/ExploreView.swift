import SwiftUI
import SwiftData
import MapKit

// Todo this view need to follow MVVM principles
struct ExploreView: View {
    @State private var searchText: String = ""
    @State private var selectedFilter: String? = nil
    @State private var currentPage: Int = 1
    @Query var vehicles: [Vehicle]
    private let pageSize: Int = 5 // maximum number of vehicles loaded
    private let filters = ["All", "Mitsubishi", "Tesla", "BMW", "Price < 200"]
    
    // Manage filteration logic
    var fullFilteredList: [Vehicle] {
        vehicles.filter { vehicle in
            let name = "\(vehicle.brandName) \(vehicle.modelName) \(vehicle.createdYear)"
            let matchesSearch = searchText.isEmpty || name
                .localizedCaseInsensitiveContains(searchText)
            let matchesFilter: Bool
            if let filter = selectedFilter {
                switch filter {
                    case "Mitsubishi", "Tesla", "BMW":
                        matchesFilter = vehicle.brandName == filter
                    case "Price < 200":
                        matchesFilter = vehicle.pricePerDay < 200
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
    
    // Manage pagination logic
    var filteredVehicles: [Vehicle] {
        let endIndex = min(currentPage * pageSize, fullFilteredList.count)
        return Array(fullFilteredList.prefix(endIndex))
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                TextField("Search cars...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(filters, id: \.self) { filter in
                            Button(action: {
                                selectedFilter = filter
                            }) {
                                Text(filter)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(
                                        selectedFilter == filter
                                        ? Color.blue
                                        : Color(.systemGray6)
                                    )
                                    .foregroundColor(
                                        selectedFilter == filter
                                        ? .white
                                        : .black
                                    )
                                    .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 8)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(filteredVehicles) { vehicle in
                            NavigationLink(
                                destination: VehicleDetailView(
                                    vehicle: vehicle)) {
                                        VehicleCardView(vehicle: vehicle)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                        }
                        
                        if filteredVehicles.count < fullFilteredList.count {
                            Button("Load More") {
                                currentPage += 1
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .navigationTitle("Explore")
            .onChange(of: searchText) { currentPage = 1 }
            .onChange(of: selectedFilter) { currentPage = 1 }
        }
    }
}
