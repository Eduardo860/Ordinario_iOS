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
                    
                    AsyncImage(url: URL(string: config.logo)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(maxWidth: 220)
                    } placeholder: {
                        ProgressView()
                            .tint(.gray)
                    }
                    
                    Text("Login")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 24)
                .padding(.top, 40)
                
                
                VStack(spacing: 20) {
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Email")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        TextField("correo@ejemplo.com", text: $email)
                            .keyboardType(.emailAddress)
                            .padding(.horizontal, 12)
                            .frame(height: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(Color(hex: config.primaryColor).opacity(0.4))
                            )
                    }
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Password")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        HStack {
                            if isPasswordVisible {
                                TextField("••••••••", text: $password)
                            } else {
                                SecureField("••••••••", text: $password)
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
                                .strokeBorder(Color(hex: config.primaryColor).opacity(0.4))
                        )
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Sign In")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color(hex: config.primaryColor))
                            .foregroundColor(.white)
                            .cornerRadius(14)
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
