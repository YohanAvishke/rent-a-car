import SwiftUI

struct VehicleCardView: View {
    let vehicle: Vehicle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
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
