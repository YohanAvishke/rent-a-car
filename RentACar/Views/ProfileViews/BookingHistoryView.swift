import SwiftUI
import SwiftData

struct BookingHistoryView: View {
    @EnvironmentObject var userManager: UserManager
    @Query var bookings: [Booking]
    
    var body: some View {
        List {
            ForEach(bookings) { booking in
                BookingHistoryItemView(booking: booking)
            }
        }
        .navigationTitle("Booking History")
        .listStyle(InsetGroupedListStyle())
    }
}

struct BookingHistoryItemView: View {
    let booking: Booking
    
    var statusColor: Color {
        switch booking.bookingStatus {
        case .Completed:
            return .green
        case .Confirmed:
            return .blue
        case .Cancelled:
            return .red
        case .Pending:
            return .orange
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(booking.vehicle.modelName)
                    .font(.headline)
                Spacer()
                Text(booking.bookingStatus.rawValue)
                    .foregroundColor(statusColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(statusColor.opacity(0.1))
                    .cornerRadius(4)
            }
            
            Text("Starting Date: \(formatDate(booking.startDate))")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("End Date: \(formatDate(booking.endDate))")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            if booking.bookingStatus == .Confirmed {
                Button("Cancle booking") {
                }
                .foregroundColor(.red)
                .padding(.top, 4)
            }
        }
        .padding(.vertical, 8)
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
