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
            Section(header: Text("个人信息")) {
                TextField("姓名", text: $name)
                TextField("电子邮箱", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                TextField("电话", text: $phone)
                    .keyboardType(.phonePad)
            }
            
            Section {
                Button("保存修改") {
                    showSaveAlert = true
                }
                .foregroundColor(.blue)
            }
        }
        .navigationTitle("编辑个人信息")
        .onAppear {
            // 加载当前用户信息
            if let user = userManager.currentUser {
                name = user.name
                email = user.email
                phone = user.phone
            }
        }
        .alert("确认保存修改?", isPresented: $showSaveAlert) {
            Button("保存", role: .none) {
                // 保存逻辑
                if let user = userManager.currentUser {
                    user.name = name
                    user.email = email
                    user.phone = phone
                    // 实际应用中需要更新到数据库
                }
                dismiss()
            }
            Button("取消", role: .cancel) { }
        }
    }
}

#Preview {
    NavigationView {
        EditProfileView()
            .environmentObject(UserManager())
    }
}
