import Foundation
import SwiftData

/// Class used to populate Model context with mock data
final class DataImporter {
    static func importInto(_ context: ModelContext) {
        // fetch the mock data
        guard let importModel = ImportModel.fetchMockData() else {
            print("Could not fetch mock data")
            return
        }
        
        // Map object are used to when another object required the mapped object
        // as an arguemnt
        var vehicleTypeMap: [String: VehicleType] = [:]
        for vehicleType in importModel.vehicleTypes {
            let typeModel = VehicleType(name: vehicleType.name, vehicles: [])
            context.insert(typeModel) // insert the data object into the context
            // Key is an unique identifier, which is reflected in the Data
            // models
            vehicleTypeMap[vehicleType.name] = typeModel
        }
        
        var dealerMap: [String: Dealer] = [:]
        for data in importModel.dealers {
            let dealer = Dealer(
                name: data.name,
                address: data.address,
                latitude: data.latitude,
                longitude: data.longitude,
                email: data.email,
                managerName: data.managerName,
                registrationDate: data.registrationDate,
                cancelationPolicy: data.cancelationPolicy,
                vehicles: []
            )
            context.insert(dealer)
            dealerMap[data.email] = dealer
        }
        
        var vehicleMap: [String: Vehicle] = [:]
        for data in importModel.vehicles {
            guard let dealer = dealerMap[data.dealerEmail],
                  let vehicleType = vehicleTypeMap[data.vehicleType],
                  let status = VehicleStatus(rawValue: data.vehicleStatus)
            else {
                continue
            }
            let vehicle = Vehicle(
                dealer: dealer,
                vehicleType: vehicleType,
                modelName: data.modelName,
                brandName: data.brandName,
                createdYear: data.createdYear,
                mileage: data.mileage,
                capacity: data.capacity,
                fuelType: data.fuelType,
                pricePerDay: data.pricePerDay,
                licensePlate: data.licensePlate,
                vehicleStatus: status,
                imageUrls: data.imageUrls,
                vehicleDescription: data.vehicleDescription
            )
            context.insert(vehicle)
            vehicleMap[data.licensePlate] = vehicle
        }
        
        var userMap: [String: User] = [:]
        for data in importModel.users {
            let user = User(
                name: data.name,
                email: data.email,
                phone: data.phone,
                passwordHash: data.passwordHash
            )
            context.insert(user)
            userMap[data.email] = user
        }
        
        for data in importModel.bookings {
            guard let user = userMap[data.userEmail],
                  let dealer = dealerMap[data.dealerEmail],
                  let vehicle = vehicleMap[data.vehicleLicense],
                  let status = BookingStatus(rawValue: data.bookingStatus)
            else {
                continue
            }
            context.insert(
                Booking(
                    user: user,
                    dealer: dealer,
                    vehicle: vehicle,
                    startDate: data.startDate,
                    endDate: data.endDate,
                    totalPrice: data.totalPrice,
                    bookingStatus: status
                )
            )
        }
        
        print("Data imported successfully")
    }
}
