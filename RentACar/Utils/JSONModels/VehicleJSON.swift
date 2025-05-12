import Foundation

struct VehicleJSON: Codable {
    let dealerEmail: String
    let vehicleType: String
    let modelName: String
    let brandName: String
    let createdYear: Int
    let mileage: Int?
    let capacity: Int?
    let fuelType: String
    let pricePerDay: Double
    let licensePlate: String
    let vehicleStatus: String
    let imageNames: [String]
    let vehicleDescription: String?
}

