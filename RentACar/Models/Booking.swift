import Foundation
import SwiftData

enum BookingStatus: String, Codable {
    case Pending = "Pending"
    case Confirmed = "Confirmed"
    case Cancelled = "Cancelled"
    case Completed = "Completed"
}

@Model
class Booking {
    var user: User
    var dealer: Dealer
    var vehicle: Vehicle
    var startDate: Date
    var endDate: Date
    var totalPrice: Double
    var bookingStatus: BookingStatus
    
    init(user: User, dealer: Dealer, vehicle: Vehicle, startDate: Date,
         endDate: Date, totalPrice: Double, bookingStatus: BookingStatus) {
        self.user = user
        self.dealer = dealer
        self.vehicle = vehicle
        self.startDate = startDate
        self.endDate = endDate
        self.totalPrice = totalPrice
        self.bookingStatus = bookingStatus
    }
}
