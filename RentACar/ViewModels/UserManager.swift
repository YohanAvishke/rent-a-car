//
//  UserManager.swift
//  RentACar
//
//  Created by Gavin Li on 5/5/2025.
//

import SwiftUI

class UserManager: ObservableObject {
    @Published var isLoggedIn: Bool = true  // 默认先登录状态，方便开发界面
    @Published var currentUser: User? = User(
        name: "Test User",
        email: "test@example.com",
        phone: "1234567890",
        passwordHash: "password",
        bookings: []
    )

    func login(email: String, password: String) {
        // 不做检查，直接登录
        isLoggedIn = true
    }

    func register(name: String, email: String, phone: String, password: String) {
        // 不做检查，直接注册
        isLoggedIn = true
    }

    func logout() {
        isLoggedIn = false
    }
}
