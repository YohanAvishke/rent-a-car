import SwiftUI
import SwiftData

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
            let fetch = FetchDescriptor<Dealer>()
            if let count = try? container.mainContext.fetchCount(fetch), count == 0 {
                DataImporter.importInto(container.mainContext)
            }
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

