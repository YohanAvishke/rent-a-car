import SwiftUI
import SwiftData

@main
struct RentACarApp: App {
    /*
     Container is dual purpose.
     First to initialise SwiftData for the project and,
     Second to make sure data initialisation only happens once per development
     build
     */
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
            // If dealers exist skip
            if let count = try?
                container.mainContext.fetchCount(FetchDescriptor<Dealer>()),
               count == 0 {
                DataImporter.importInto(container.mainContext)
            }
#endif
        } catch {
            fatalError("Failed to initialize model container: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().modelContainer(container)
        }
    }
}
