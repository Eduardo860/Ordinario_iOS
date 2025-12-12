import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible = false
    
    @EnvironmentObject var vm: SchoolViewModel
    
    var body: some View {
        
        let config = vm.config ?? SchoolConfig.preview
        
        ZStack {
            Color(hex: config.primaryColor)
                .ignoresSafeArea()
                
            VStack(spacing: 32) {
                
                VStack(spacing: 16) {
                    
                    // Logo centrado con un círculo
                    AsyncImage(url: URL(string: config.logo)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(maxWidth: 200)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                            .tint(.gray)
                    }
                    
                    Text(config.name)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .padding(.top, 10)

                    Text("Login")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 8)
                        
                }
                .padding(.horizontal, 24)
                .padding(.top, 40)
                
                
                VStack(spacing: 20) {
                    
                    // Email Field
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Email")
                            .font(.caption)
                            .foregroundColor(.white)
                        
                        TextField("correo@ejemplo.com", text: $email)
                            .keyboardType(.emailAddress)
                            .padding(.horizontal, 12)
                            .frame(height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white)
                                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
                            )
                            .padding(.horizontal)
                    }
                    
                    // Password Field
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .font(.caption)
                            .foregroundColor(.white)
                        
                        HStack {
                            if isPasswordVisible {
                                TextField("••••••••", text: $password)
                                    .autocapitalization(.none)
                            } else {
                                SecureField("••••••••", text: $password)
                                    .autocapitalization(.none)
                            }
                            
                            Button {
                                isPasswordVisible.toggle()
                            } label: {
                                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                    .foregroundColor(Color(hex: config.primaryColor))
                            }
                        }
                        .padding(.horizontal, 12)
                        .frame(height: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
                        )
                        .padding(.horizontal)
                    }
                    
                    // Sign In Button
                    Button {
                        // Acción de inicio de sesión
                    } label: {
                        Text("Sign In")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(hex: config.primaryColor))
                            .foregroundColor(.white)
                            .cornerRadius(14)
                            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 6)
                    }
                    .padding(.top, 4)
                    
                }
                .padding(24)
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.08), radius: 12)
                )
                .padding(.horizontal, 24)
                
                Spacer()
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(SchoolViewModel())
}
