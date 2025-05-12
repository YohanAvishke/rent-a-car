import Foundation
import SwiftData

final class DataImporter {
    static func importInto(_ context: ModelContext) {
        guard let importModel = ImportModel.fetchMockData() else {
            print("Could not fetch mock data")
            return
        }
        
        var vehicleTypeMap: [String: VehicleType] = [:]
        for vt in importModel.vehicleTypes {
            let typeModel = VehicleType(name: vt.name, vehicles: [])
            context.insert(typeModel)
            vehicleTypeMap[vt.name] = typeModel
        }
        
        var dealerMap: [String: Dealer] = [:]
        for d in importModel.dealers {
            let dealer = Dealer(
                name: d.name,
                address: d.address,
                latitude: d.latitude,
                longitude: d.longitude,
                email: d.email,
                managerName: d.managerName,
                registrationDate: d.registrationDate,
                cancelationPolicy: d.cancelationPolicy,
                vehicles: []
            )
            context.insert(dealer)
            dealerMap[d.email] = dealer
        }
        
        var vehicleMap: [String: Vehicle] = [:]
        for v in importModel.vehicles {
            guard let dealer = dealerMap[v.dealerEmail],
                  let vehicleType = vehicleTypeMap[v.vehicleType],
                  let status = VehicleStatus(rawValue: v.vehicleStatus) else {
                continue
            }
            let vehicle = Vehicle(
                dealer: dealer,
                vehicleType: vehicleType,
                modelName: v.modelName,
                brandName: v.brandName,
                createdYear: v.createdYear,
                mileage: v.mileage,
                capacity: v.capacity,
                fuelType: v.fuelType,
                pricePerDay: v.pricePerDay,
                licensePlate: v.licensePlate,
                vehicleStatus: status,
                imageUrls: v.imageUrls,
                vehicleDescription: v.vehicleDescription
            )
            context.insert(vehicle)
            vehicleMap[v.licensePlate] = vehicle
        }
        
        var userMap: [String: User] = [:]
        for u in importModel.users {
            let user = User(
                name: u.name,
                email: u.email,
                phone: u.phone,
                passwordHash: u.passwordHash
            )
            context.insert(user)
            userMap[u.email] = user
        }
        
        for b in importModel.bookings {
            guard let user = userMap[b.userEmail],
                  let dealer = dealerMap[b.dealerEmail],
                  let vehicle = vehicleMap[b.vehicleLicense],
                  let status = BookingStatus(rawValue: b.bookingStatus) else {
                continue
            }
            
            let booking = Booking(
                user: user,
                dealer: dealer,
                vehicle: vehicle,
                startDate: b.startDate,
                endDate: b.endDate,
                totalPrice: b.totalPrice,
                bookingStatus: status
            )
            context.insert(booking)
        }
        
        print("Data imported successfully")
    }
}
