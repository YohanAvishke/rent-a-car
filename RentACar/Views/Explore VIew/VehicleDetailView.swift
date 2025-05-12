import SwiftUI
import MapKit

struct VehicleDetailView: View {
    let vehicle: Vehicle
    @State private var cameraPosition: MapCameraPosition
    
    init(vehicle: Vehicle) {
        self.vehicle = vehicle
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: vehicle.dealer.latitude, longitude: vehicle.dealer.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        _cameraPosition = State(initialValue: .region(region))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Image
                if let imageUrlString = vehicle.imageUrls.first, let url = URL(string: imageUrlString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                            case .empty:
                                ProgressView().frame(height: 220)
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 220)
                                    .clipped()
                            case .failure:
                                Image(systemName: "photo.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 220)
                                    .foregroundColor(.gray)
                            @unknown default:
                                EmptyView()
                        }
                    }
                    .cornerRadius(12)
                }
                
                // Vehicle Title & Status
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(vehicle.brandName) \(vehicle.modelName) \(String(vehicle.createdYear))")
                        .font(.title)
                        .bold()
                    
                    Text(vehicle.vehicleStatus.rawValue)
                        .font(.caption)
                        .padding(6)
                        .background(vehicle.vehicleStatus == .Available ? Color.green.opacity(0.2) : Color.orange.opacity(0.2))
                        .cornerRadius(6)
                }
                
                // Description
                if let desc = vehicle.vehicleDescription {
                    Text(desc)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Vehicle Specs
                Group {
                    HStack {
                        Label("\(vehicle.fuelType)", systemImage: "fuelpump")
                        Spacer()
                        Label("\(vehicle.capacity ?? 0) seats", systemImage: "person.3.fill")
                    }
                    HStack {
                        Label("\(vehicle.mileage ?? 0) km", systemImage: "speedometer")
                        Spacer()
                        Label("License: \(vehicle.licensePlate)", systemImage: "car.fill")
                    }
                }
                .font(.subheadline)
                .padding(.vertical, 4)
                
                Divider()
                
                // Pricing
                VStack(alignment: .leading, spacing: 4) {
                    Text("Price")
                        .font(.headline)
                    Text("$\(Int(vehicle.pricePerDay)) per day")
                        .font(.title3)
                        .bold()
                }
                
                Divider()
                
                // Dealer Info
                VStack(alignment: .leading, spacing: 4) {
                    Text("Dealer Information")
                        .font(.headline)
                    
                    Label(vehicle.dealer.name, systemImage: "building.2")
                    Label(vehicle.dealer.address, systemImage: "mappin")
                    Label(vehicle.dealer.email, systemImage: "envelope")
                    Label("Manager: \(vehicle.dealer.managerName)", systemImage: "person.fill")
                    
                    Map(position: $cameraPosition) {
                        Marker(vehicle.dealer.name, coordinate: CLLocationCoordinate2D(
                            latitude: vehicle.dealer.latitude,
                            longitude: vehicle.dealer.longitude
                        ))
                    }
                    .frame(height: 180)
                    .cornerRadius(10)
                }
                .font(.subheadline)
                
                Divider()
                
                // Cancellation Policy
                VStack(alignment: .leading, spacing: 4) {
                    Text("Cancellation Policy")
                        .font(.headline)
                    Text(vehicle.dealer.cancelationPolicy)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Vehicle Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
