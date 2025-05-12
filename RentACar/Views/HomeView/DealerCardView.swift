import SwiftUI
import MapKit

struct DealerCardView: View {
    var dealer: Dealer
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(dealer.name)
                .font(.title2)
                .bold()
            
            Text(dealer.address)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text("📧 \(dealer.email)")
                .font(.subheadline)
            
            Text("🧑‍💼 Manager: \(dealer.managerName)")
                .font(.subheadline)
            
            Map(coordinateRegion: .constant(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: dealer.latitude,
                        longitude: dealer.longitude
                    ),
                    span: MKCoordinateSpan(latitudeDelta: 0.01,
                                           longitudeDelta: 0.01)
                )
            ), annotationItems: [dealer]) { dealer in
                MapMarker(coordinate: CLLocationCoordinate2D(
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
