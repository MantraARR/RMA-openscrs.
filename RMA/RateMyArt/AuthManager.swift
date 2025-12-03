import Foundation
import Combine

class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var isGuest: Bool = false

    func login() {
        // In a real app, this would involve API calls
        self.isLoggedIn = true
        self.isGuest = false
    }

    func loginAsGuest() {
        self.isGuest = true
        self.isLoggedIn = true
    }

    func logout() {
        self.isLoggedIn = false
        self.isGuest = false
    }

    func signup() {
        // In a real app, this would involve API calls
        self.isLoggedIn = true
        self.isGuest = false
    }
} 