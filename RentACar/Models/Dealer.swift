import Foundation
import SwiftData

@Model
class Dealer {
    var name: String
    @Attribute(.unique)
    var address: String
    @Attribute(.unique)
    var email: String
    var managerName: String
    var registrationDate: Date
    var cancelationPolicy: String
    @Relationship(deleteRule: .cascade, inverse: \Vehicle.dealer)
    var vehicles: [Vehicle]
    @Relationship(deleteRule: .cascade, inverse: \Booking.dealer)
    var bookings: [Booking]?
    
    init(name: String, address: String, email: String, managerName: String,
         registrationDate: Date, cancelationPolicy: String, vehicles: [Vehicle],
         bookings: [Booking]? = nil) {
        self.name = name
        self.address = address
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
        Dealer(
            name: "Swift Motors",
            address: "123 Swift Lane",
            email: "dealer@swiftmotors.com",
            managerName: "Alice Johnson",
            registrationDate: .now,
            cancelationPolicy: "Full refund up to 24 hours before rental.",
            vehicles: []
        )
    }
    
    static var apexRentals: Dealer {
        Dealer(
            name: "Apex Rentals",
            address: "456 Apex Road",
            email: "info@apexrentals.com",
            managerName: "Mark Lee",
            registrationDate: .now,
            cancelationPolicy: "Cancellations within 12 hours may incur a fee.",
            vehicles: []
        )
    }
}
