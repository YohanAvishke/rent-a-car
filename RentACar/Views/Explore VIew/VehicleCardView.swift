import SwiftUI

struct VehicleCardView: View {
    let vehicle: Vehicle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let urlString = vehicle.imageUrls.first,
               let url = URL(string: urlString) {
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
