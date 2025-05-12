import Foundation

struct BookingJSON: Codable {
    let userEmail: String
    let dealerEmail: String
    let vehicleLicense: String
    let startDate: Date
    let endDate: Date
    let totalPrice: Double
    let bookingStatus: String
}

