import SwiftUI
import SwiftData
import MapKit

struct DealerCardView: View {
    var dealer: Dealer
    @State private var cameraPosition: MapCameraPosition
    
    init(dealer: Dealer) {
        self.dealer = dealer
        // Configuring the camera position for the map
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: dealer.latitude,
                                           longitude: dealer.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        _cameraPosition = State(initialValue: .region(region))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(dealer.name)
                .font(.title2)
                .bold()
                .foregroundColor(.primary)
            
            Text(dealer.address)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("📧 \(dealer.email)")
                .font(.subheadline)
            
            Text("🧑‍💼 Manager: \(dealer.managerName)")
                .font(.subheadline)
            
            Map(position: $cameraPosition) {
                Marker(dealer.name, coordinate: CLLocationCoordinate2D(
                    latitude: dealer.latitude,
                    longitude: dealer.longitude
                ))
            }
            .frame(height: 180)
            .cornerRadius(10)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}
