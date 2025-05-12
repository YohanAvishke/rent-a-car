import Foundation

struct UserJSON: Codable {
    let name: String
    let email: String
    let phone: String
    let passwordHash: String
}

