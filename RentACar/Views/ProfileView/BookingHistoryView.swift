//
//  BookingHistoryView.swift
//  RentACar
//
//  Created by Gavin Li on 5/8/2025.
//

import SwiftUI

struct BookingHistoryView: View {
    @EnvironmentObject var userManager: UserManager
    
    // 示例预订历史
    let bookings = [
        BookingHistoryItem(id: "1", vehicleName: "Tesla Model 3", startDate: Date(), endDate: Date().addingTimeInterval(86400*3), status: .Completed),
        BookingHistoryItem(id: "2", vehicleName: "BMW X5", startDate: Date().addingTimeInterval(86400*7), endDate: Date().addingTimeInterval(86400*10), status: .Confirmed),
        BookingHistoryItem(id: "3", vehicleName: "Mitsubishi Outlander", startDate: Date().addingTimeInterval(-86400*10), endDate: Date().addingTimeInterval(-86400*7), status: .Cancelled)
    ]
    
    var body: some View {
        List {
            ForEach(bookings) { booking in
                BookingHistoryItemView(booking: booking)
            }
        }
        .navigationTitle("预订历史")
        .listStyle(InsetGroupedListStyle())
    }
}

struct BookingHistoryItem: Identifiable {
    let id: String
    let vehicleName: String
    let startDate: Date
    let endDate: Date
    let status: BookingStatus
}

struct BookingHistoryItemView: View {
    let booking: BookingHistoryItem
    
    var statusColor: Color {
        switch booking.status {
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
                Text(booking.vehicleName)
                    .font(.headline)
                Spacer()
                Text(booking.status.rawValue)
                    .foregroundColor(statusColor)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(statusColor.opacity(0.1))
                    .cornerRadius(4)
            }
            
            Text("开始日期: \(formatDate(booking.startDate))")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("结束日期: \(formatDate(booking.endDate))")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            if booking.status == .Confirmed {
                Button("取消预订") {
                    // 取消预订逻辑
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

#Preview {
    NavigationView {
        BookingHistoryView()
            .environmentObject(UserManager())
    }
}
