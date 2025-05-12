import SwiftUI
import SwiftData

struct DealerListView: View {
    @Query var dealers: [Dealer]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(dealers, id: \.email) { dealer in
                        NavigationLink(destination:
                                        DealerDetailView(dealer: dealer)) {
                            DealerCardView(dealer: dealer)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Our Dealers")
        }
    }
}
