import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        NavigationView {
        VStack {
                Image("AppLogo")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .padding(.bottom, 50)

            TextField("Email", text: $email)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)

            SecureField("Password", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.vertical, 10)

            Button(action: {
                // Handle login logic here (e.g., API call)
                print("Login tapped for email: \(email)")
                authManager.login() // Simulate successful login
            }) {
                Text("Log In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)

            Button(action: {
                    authManager.loginAsGuest()
            }) {
                    Text("Continue as Guest")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.top, 10)

                Spacer()
                
                NavigationLink(destination: SignUpView().environmentObject(authManager)) {
                Text("Don't have an account? Sign Up")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
                .padding(.bottom)

            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthManager())
    }
} 