//
//  EditProfileView.swift
//  RentACar
//
//  Created by Gavin Li on 5/8/2025.
//

import SwiftUI

struct EditProfileView: View {
    @EnvironmentObject var userManager: UserManager
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var phone: String = ""
    @State private var showSaveAlert = false
    
    var body: some View {
        Form {
            Section(header: Text("Infomation")) {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                TextField("Phone", text: $phone)
                    .keyboardType(.phonePad)
            }
            
            Section {
                Button("Save") {
                    showSaveAlert = true
                }
                .foregroundColor(.blue)
            }
        }
        .navigationTitle("Edit Information")
        .onAppear {
            // 加载当前用户信息
            if let user = userManager.currentUser {
                name = user.name
                email = user.email
                phone = user.phone
            }
        }
        .alert("Are you sure to save the changes?", isPresented: $showSaveAlert) {
            Button("Save", role: .none) {
                // 保存逻辑
                if let user = userManager.currentUser {
                    user.name = name
                    user.email = email
                    user.phone = phone
                    // 实际应用中需要更新到数据库
                }
                dismiss()
            }
            Button("Cancle", role: .cancel) { }
        }
    }
}

#Preview {
    NavigationView {
        EditProfileView()
            .environmentObject(UserManager())
    }
}
