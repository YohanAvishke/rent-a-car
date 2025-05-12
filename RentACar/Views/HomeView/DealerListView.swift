import SwiftUI
import SwiftData
import MapKit

struct DealerListView: View {
    @Query var dealers: [Dealer]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(dealers, id: \.email) { dealer in
                        DealerCardView(dealer: dealer)
                    }
                }
                .padding()
            }
            .navigationTitle("Our Dealers")
        }
    }
}


#Preview {
    DealerListView()
}
