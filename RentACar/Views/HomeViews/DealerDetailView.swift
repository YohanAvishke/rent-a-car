import SwiftUI
import MapKit

struct DealerDetailView: View {
    let dealer: Dealer
    @State private var cameraPosition: MapCameraPosition
    
    init(dealer: Dealer) {
        self.dealer = dealer
        let region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: dealer.latitude,
                                           longitude: dealer.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
        _cameraPosition = State(initialValue: .region(region))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Map(position: $cameraPosition) {
                    Marker(dealer.name, coordinate: CLLocationCoordinate2D(
                        latitude: dealer.latitude,
                        longitude: dealer.longitude
                    ))
                }
                .frame(height: 250)
                .cornerRadius(12)
                
                Group {
                    Label(dealer.name, systemImage: "building.2.fill")
                        .font(.title2.bold())
                    
                    Label(dealer.address, systemImage: "mappin.and.ellipse")
                        .font(.subheadline)
                    
                    Label(dealer.email, systemImage: "envelope.fill")
                        .font(.subheadline)
                    
                    Label("Manager: \(dealer.managerName)",
                          systemImage: "person.fill")
                    .font(.subheadline)
                    
                    Group {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Cancellation Policy")
                                .font(.headline)
                                .padding(.bottom, 4)
                            
                            Text(dealer.cancelationPolicy)
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.leading)
                        }
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal)
                
                Button {
                    print("Clicked Explore Vehicles")
                } label: {
                    Label("Explore Vehicles", systemImage: "car")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .navigationTitle("Dealer Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}
