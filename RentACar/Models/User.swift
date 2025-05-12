import Foundation
import SwiftData

@Model
class User {
    var name: String
    var email: String
    @Attribute(.unique)
    var phone: String
    @Attribute(.allowsCloudEncryption)
    var passwordHash: String
    @Relationship(deleteRule: .cascade, inverse: \Booking.user)
    var bookings: [Booking]?
    
    init(name: String, email: String, phone: String, passwordHash: String,
         bookings: [Booking]? = nil) {
        self.name = name
        self.email = email
        self.phone = phone
        self.passwordHash = passwordHash
        self.bookings = bookings
    }
}
