import SwiftData
import SwiftUI

class UserManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUser: User?
    
    private var context: ModelContext?
    
    func setContext(_ context: ModelContext) {
        self.context = context
    }
    
    func login(email: String, password: String) {
        guard let context else { return }
        
        let request = FetchDescriptor<User>(predicate: #Predicate {
            $0.email == email && $0.passwordHash == password
        })
        
        do {
            if let user = try context.fetch(request).first {
                currentUser = user
                isLoggedIn = true
            } else {
                isLoggedIn = false
            }
        } catch {
            print("Login failed: \(error)")
        }
    }
    
    func register(name: String, email: String, phone: String, password: String) {
        guard let context else { return }
        
        let newUser = User(name: name, email: email, phone: phone, passwordHash: password, bookings: [])
        context.insert(newUser)
        
        do {
            try context.save()
            currentUser = newUser
            isLoggedIn = true
        } catch {
            print("Registration failed: \(error)")
        }
    }
    
    func logout() {
        currentUser = nil
        isLoggedIn = false
    }
}

