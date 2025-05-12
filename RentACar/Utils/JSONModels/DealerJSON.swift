import Foundation

struct DealerJSON: Codable {
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let email: String
    let managerName: String
    let registrationDate: Date
    let cancelationPolicy: String
}
