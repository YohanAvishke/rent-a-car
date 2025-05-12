import Foundation
import SwiftData

@Model
class Dealer {
    var name: String
    @Attribute(.unique)
    var address: String
    var latitude: Double
    var longitude: Double
    @Attribute(.unique)
    var email: String
    var managerName: String
    var registrationDate: Date
    var cancelationPolicy: String
    @Relationship(deleteRule: .cascade, inverse: \Vehicle.dealer)
    var vehicles: [Vehicle]
    @Relationship(deleteRule: .cascade, inverse: \Booking.dealer)
    var bookings: [Booking]?
    
    init(name: String, address: String, latitude: Double, longitude: Double,
         email: String, managerName: String, registrationDate: Date,
         cancelationPolicy: String, vehicles: [Vehicle],
         bookings: [Booking]? = nil) {
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.email = email
        self.managerName = managerName
        self.registrationDate = registrationDate
        self.cancelationPolicy = cancelationPolicy
        self.vehicles = vehicles
        self.bookings = bookings
    }
}

extension Dealer {
    static var swiftMotors: Dealer {
        let dealer = Dealer(
            name: "Swift Motors",
            address: "123 Swift Lane",
            latitude: -33.8688,
            longitude: 151.2093,
            email: "dealer@swiftmotors.com",
            managerName: "Alice Johnson",
            registrationDate: .now,
            cancelationPolicy: "Full refund up to 24 hours before rental.",
            vehicles: []
        )
        return dealer
    }
    
    static var apexRentals: Dealer {
        let dealer = Dealer(
            name: "Apex Rentals",
            address: "456 Apex Road",
            latitude: -37.8136,
            longitude: 144.9631,
            email: "info@apexrentals.com",
            managerName: "Mark Lee",
            registrationDate: .now,
            cancelationPolicy: "Cancellations within 12 hours may incur a fee.",
            vehicles: []
        )
        return dealer
    }
}
