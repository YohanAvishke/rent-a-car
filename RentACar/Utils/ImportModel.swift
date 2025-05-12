import Foundation

struct ImportModel: Codable {
    let vehicleTypes: [VehicleTypeJSON]
    let dealers: [DealerJSON]
    let vehicles: [VehicleJSON]
    let users: [UserJSON]
    let bookings: [BookingJSON]
    
    static func fetchMockData() -> ImportModel? {
        guard let url = Bundle.main.url(
            forResource: "mock-data", withExtension: "json") else {
            print("JSON file not found.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode(ImportModel.self, from: data)
            return decoded
        } catch {
            print("Failed to decode JSON: \(error)")
            return nil
        }
    }
}
