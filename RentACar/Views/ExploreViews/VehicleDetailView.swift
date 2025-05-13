import SwiftUI
import SwiftData
import MapKit

struct VehicleDetailView: View {
    let vehicle: Vehicle
    @Environment(\.modelContext) private var context
    @EnvironmentObject var userManager: UserManager
    
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
    
    @State private var cameraPosition: MapCameraPosition
    @State private var bookingConfirmed = false
    @State private var bookingError = false
    
    init(vehicle: Vehicle) {
        self.vehicle = vehicle
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: vehicle.dealer.latitude, longitude: vehicle.dealer.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        _cameraPosition = State(initialValue: .region(region))
    }
    
    var numberOfDays: Int {
        let days = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        return max(days, 1)
    }
    
    var totalPrice: Double {
        Double(numberOfDays) * vehicle.pricePerDay
    }
    
    private func createBooking() {
        do {
            let booking = Booking(
                user: userManager.currentUser!,
                dealer: vehicle.dealer,
                vehicle: vehicle,
                startDate: startDate,
                endDate: endDate,
                totalPrice: totalPrice,
                bookingStatus: .Confirmed
            )
            context.insert(booking)
            try context.save()
            bookingConfirmed = true
        } catch {
            bookingError = true
            print("Failed to save booking: \(error)")
        }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let imageName = vehicle.imageNames.first {
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(12)
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .foregroundColor(.gray)
                }
                
                // Vehicle Info
                Text("\(vehicle.brandName) \(vehicle.modelName) \(String(vehicle.createdYear))")
                    .font(.title)
                    .bold()
                
                Text(vehicle.vehicleDescription ?? "No description available")
                    .font(.body)
                    .foregroundColor(.secondary)
                
                Divider()
                
                Group {
                    Label("\(vehicle.fuelType)", systemImage: "fuelpump")
                    Label("\(vehicle.mileage ?? 0) km", systemImage: "speedometer")
                    Label("\(vehicle.capacity ?? 0) seats", systemImage: "person.3.fill")
                    Label("License: \(vehicle.licensePlate)", systemImage: "car.fill")
                }
                .font(.subheadline)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Dealer Info")
                        .font(.headline)
                    Label(vehicle.dealer.name, systemImage: "building.2")
                    Label(vehicle.dealer.email, systemImage: "envelope")
                    Label(vehicle.dealer.address, systemImage: "mappin")
                    Label("Manager: \(vehicle.dealer.managerName)", systemImage: "person")
                }
                
                Map(position: $cameraPosition) {
                    Marker(vehicle.dealer.name, coordinate: CLLocationCoordinate2D(
                        latitude: vehicle.dealer.latitude,
                        longitude: vehicle.dealer.longitude
                    ))
                }
                .frame(height: 180)
                .cornerRadius(10)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Book Vehicle")
                        .font(.headline)
                    
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    DatePicker("End Date", selection: $endDate, in: startDate..., displayedComponents: .date)
                    
                    Text("Total Days: \(numberOfDays)")
                    Text("Total Price: $\(Int(totalPrice))")
                        .font(.title3)
                        .bold()
                }
                
                Button("Book Now") {
                    createBooking()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                if bookingConfirmed {
                    Text("Booking Confirmed!").foregroundColor(.green)
                } else if bookingError {
                    Text("Failed to book. Please try again.").foregroundColor(.red)
                }
                
                Divider()
                
                VStack(alignment: .leading) {
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
