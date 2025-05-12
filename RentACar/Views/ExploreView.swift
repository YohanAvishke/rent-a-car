import SwiftUI
import SwiftData
import MapKit

struct ExploreView: View {
    @State private var searchText: String = ""
    @State private var selectedFilter: String? = nil
    
    @Query var vehicles: [Vehicle]
    
    @State private var currentPage: Int = 1
    private let pageSize: Int = 5
    
    let filters = ["All", "Mitsubishi", "Tesla", "BMW", "Price < 200"]
    
    // Full filter logic
    var fullFilteredList: [Vehicle] {
        vehicles.filter { vehicle in
            let name = "\(vehicle.brandName) \(vehicle.modelName) \(vehicle.createdYear)"
            let matchesSearch = searchText.isEmpty || name.localizedCaseInsensitiveContains(searchText)
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
    
    // Paginated result
    var filteredVehicles: [Vehicle] {
        let endIndex = min(currentPage * pageSize, fullFilteredList.count)
        return Array(fullFilteredList.prefix(endIndex))
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // Search field
                TextField("Search cars...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Filter bar
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
                
                // Vehicle List
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(filteredVehicles) { vehicle in
                            //                            NavigationLink(destination: VehicleDetailView(vehicle: vehicle)) {
                            //                                VehicleCardView(vehicle: vehicle)
                            //                            }
                            //                            .buttonStyle(PlainButtonStyle())
                            VehicleCardView(vehicle: vehicle)
                        }
                        
                        // Load More
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

struct VehicleCardView: View {
    let vehicle: Vehicle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let urlString = vehicle.imageUrls.first, let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                        case .empty:
                            ProgressView()
                                .frame(height: 200)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .clipped()
                                .cornerRadius(12)
                        case .failure:
                            Image(systemName: "photo.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 200)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                    }
                }
            }
            
            Text("\(vehicle.brandName) \(vehicle.modelName) \(vehicle.createdYear)")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(vehicle.dealer.address)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("$\(Int(vehicle.pricePerDay))/day")
                .font(.title3)
                .bold()
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}

