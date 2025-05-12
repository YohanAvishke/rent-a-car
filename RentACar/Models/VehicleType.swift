import Foundation
import SwiftData

@Model
class VehicleType {
    @Attribute(.unique)
    var name: String // e.g., Sedan, SUV, Van
    @Relationship(deleteRule: .cascade, inverse: \Vehicle.vehicleType)
    var vehicles: [Vehicle]
    
    init(name: String, vehicles: [Vehicle]) {
        self.name = name
        self.vehicles = vehicles
    }
}
