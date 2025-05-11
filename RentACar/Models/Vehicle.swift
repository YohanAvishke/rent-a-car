import Foundation
import SwiftData

enum VehicleStatus: Codable {
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
    @Attribute(originalName: "imageUrls")
    var imageUrls: [String]
    var vehicleDescription: String?
    @Relationship(deleteRule: .cascade, inverse: \Booking.vehicle)
    var bookings: [Booking]?
    
    init(dealer: Dealer, vehicleType: VehicleType, modelName: String,
         brandName: String, createdYear: Int, mileage: Int? = nil,
         capacity: Int? = nil, fuelType: String, pricePerDay: Double,
         licensePlate: String, vehicleStatus: VehicleStatus,
         imageUrls: [String], vehicleDescription: String? = nil,
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
        self.imageUrls = imageUrls
        self.vehicleDescription = vehicleDescription
        self.bookings = bookings
    }
}

extension Vehicle {
    static func teslaX(dealer: Dealer) -> Vehicle {
        Vehicle(
            dealer: dealer,
            vehicleType: .suv,
            modelName: "Model X",
            brandName: "Tesla",
            createdYear: 2022,
            mileage: 10000,
            capacity: 5,
            fuelType: "Electric",
            pricePerDay: 150.0,
            licensePlate: "TESLA-X",
            vehicleStatus: .Available,
            imageUrls: ["tesla_modelx.jpg"],
            vehicleDescription: "Luxury electric SUV"
        )
    }
    
    static func outlander(dealer: Dealer) -> Vehicle {
        Vehicle(
            dealer: dealer,
            vehicleType: .suv,
            modelName: "Outlander",
            brandName: "Mitsubishi",
            createdYear: 2021,
            mileage: 12000,
            capacity: 5,
            fuelType: "Hybrid",
            pricePerDay: 99.0,
            licensePlate: "MIT-456",
            vehicleStatus: .Available,
            imageUrls: ["outlander.jpg"],
            vehicleDescription: "Reliable and efficient"
        )
    }
    
    static func camry(dealer: Dealer) -> Vehicle {
        Vehicle(
            dealer: dealer,
            vehicleType: .sedan,
            modelName: "Camry",
            brandName: "Toyota",
            createdYear: 2020,
            mileage: 25000,
            capacity: 5,
            fuelType: "Petrol",
            pricePerDay: 80.0,
            licensePlate: "TOY-789",
            vehicleStatus: .Available,
            imageUrls: ["camry.jpg"],
            vehicleDescription: "Comfortable sedan for city travel"
        )
    }
    
    static func accord(dealer: Dealer) -> Vehicle {
        Vehicle(
            dealer: dealer,
            vehicleType: .sedan,
            modelName: "Accord",
            brandName: "Honda",
            createdYear: 2019,
            mileage: 30000,
            capacity: 5,
            fuelType: "Petrol",
            pricePerDay: 75.0,
            licensePlate: "HON-321",
            vehicleStatus: .Available,
            imageUrls: ["accord.jpg"],
            vehicleDescription: "Great for families"
        )
    }
}
