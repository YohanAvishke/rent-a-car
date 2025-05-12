//
//  ContactUsView.swift
//  RentACar
//
//  Created by Gavin Li on 5/8/2025.
//

import SwiftUI

struct ContactUsView: View {
    @Environment(\.dismiss) var dismiss
    @State private var subject = ""
    @State private var message = ""
    @State private var showSuccessAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("content")) {
                    TextField("Subject", text: $subject)
                    
                    ZStack(alignment: .topLeading) {
                        if message.isEmpty {
                            Text("Please write your questions or feedback...")
                                .foregroundColor(.gray)
                                .padding(.top, 8)
                                .padding(.leading, 4)
                        }
                        TextEditor(text: $message)
                            .frame(minHeight: 150)
                            .opacity(message.isEmpty ? 0.25 : 1)
                    }
                }
                
                Section {
                    Button("submit") {
                        // 提交逻辑
                        showSuccessAlert = true
                    }
                    .foregroundColor(.blue)
                }
                
                Section(header: Text("Other Contact")) {
                    HStack {
                        Image(systemName: "envelope")
                        Text("support@rentacar.com")
                    }
                    
                    HStack {
                        Image(systemName: "phone")
                        Text("+61 123 4567 8910")
                    }
                }
            }
            .navigationTitle("Contact Us")
            .navigationBarItems(trailing: Button("Close") {
                dismiss()
            })
            .alert("submit successfully", isPresented: $showSuccessAlert) {
                Button("comfirm", role: .none) {
                    dismiss()
                }
            } message: {
                Text("We will reply you in 24 hours")
            }
        }
    }
}

#Preview {
    ContactUsView()
}
