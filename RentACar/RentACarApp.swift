import SwiftUI
import SwiftData

func seedIfNeeded(context: ModelContext) {
    let fetch = FetchDescriptor<Vehicle>()
    if let count = try? context.fetchCount(fetch), count > 0 { return }
    
    let suv = VehicleType.suv
    let sedan = VehicleType.sedan
    context.insert(suv)
    context.insert(sedan)
    
    let dealer1 = Dealer.swiftMotors
    let dealer2 = Dealer.apexRentals
    context.insert(dealer1)
    context.insert(dealer2)
    
    let v1 = Vehicle.teslaX(dealer: dealer1)
    let v2 = Vehicle.outlander(dealer: dealer1)
    let v3 = Vehicle.camry(dealer: dealer2)
    let v4 = Vehicle.accord(dealer: dealer2)
    context.insert(v1)
    context.insert(v2)
    context.insert(v3)
    context.insert(v4)
    
    let user1 = User.john
    let user2 = User.sarah
    context.insert(user1)
    context.insert(user2)
    
    let b1 = Booking.booking1(user: user1, dealer: dealer1, vehicle: v1)
    let b2 = Booking.booking2(user: user1, dealer: dealer2, vehicle: v3)
    let b3 = Booking.booking1(user: user2, dealer: dealer1, vehicle: v2)
    let b4 = Booking.booking2(user: user2, dealer: dealer2, vehicle: v4)
    context.insert(b1)
    context.insert(b2)
    context.insert(b3)
    context.insert(b4)
}


@main
struct RentACarApp: App {
    @State private var container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(
                for: User.self,
                Dealer.self,
                VehicleType.self,
                Vehicle.self,
                Booking.self
            )
#if DEBUG
            seedIfNeeded(context: container.mainContext)
            print("Seeding complete")
#endif
        } catch {
            fatalError("Failed to initialize model container: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(container)
        }
    }
}
