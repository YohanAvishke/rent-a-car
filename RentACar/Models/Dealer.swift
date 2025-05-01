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

