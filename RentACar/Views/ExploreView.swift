import SwiftUI
import SwiftData

struct ExploreView: View {
    @State private var searchText: String = ""
    @State private var selectedFilter: String? = nil
    @Query var vehicles: [Vehicle]
    let filters = ["All", "Mitsubishi", "Tesla", "BMW", "Price < 200"]
    
    var filteredVehicles: [Vehicle] {
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
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                // Search
                TextField("Search cars...", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                // Filters
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
                
                // Vehicle cards
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(filteredVehicles) { vehicle in
                            VehicleCardView(vehicle: vehicle)
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

struct VehicleCardView: View {
    let vehicle: Vehicle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let imageName = vehicle.imageUrls.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .cornerRadius(12)
            }
            
            Text("\(vehicle.brandName) \(vehicle.modelName) \(vehicle.createdYear)")
                .font(.headline)
            
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

