import Foundation
import SwiftData

enum VehicleStatus: String, Codable {
    case Available
    case Rented
    case Maintenance
}

@Model
class Vehicle {
    var dealer: Dealer
    var vehicleType: VehicleType
    var modelName: String
    var brandName: String
    var createdYear: Int
    var mileage: Int? // in kilometers
    var capacity: Int?
    var fuelType: String // e.g., Petrol, Diesel, Electric
    var pricePerDay: Double
    @Attribute(.unique)
    var licensePlate: String
    var vehicleStatus: VehicleStatus
    @Attribute(originalName: "imageNames")
    var imageNames: [String]
    var vehicleDescription: String?
    @Relationship(deleteRule: .cascade, inverse: \Booking.vehicle)
    var bookings: [Booking]?
    
    init(dealer: Dealer, vehicleType: VehicleType, modelName: String,
         brandName: String, createdYear: Int, mileage: Int? = nil,
         capacity: Int? = nil, fuelType: String, pricePerDay: Double,
         licensePlate: String, vehicleStatus: VehicleStatus,
         imageNames: [String], vehicleDescription: String? = nil,
         bookings: [Booking]? = nil) {
        self.dealer = dealer
        self.vehicleType = vehicleType
        self.modelName = modelName
        self.brandName = brandName
        self.createdYear = createdYear
        self.mileage = mileage
        self.capacity = capacity
        self.fuelType = fuelType
        self.pricePerDay = pricePerDay
        self.licensePlate = licensePlate
        self.vehicleStatus = vehicleStatus
        self.imageNames = imageNames
        self.vehicleDescription = vehicleDescription
        self.bookings = bookings
    }
}
