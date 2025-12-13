//
//  Ordinario_iOSApp.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 03/12/25.
//

import SwiftUI
import Firebase
import Combine

// Firebase AppDelegate
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions:  [UIApplication.LaunchOptionsKey :  Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}

@main
struct Ordinario_iOSApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var schoolViewModel = SchoolViewModel()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authViewModel.isAuthenticated {
                    // Show main app when authenticated
                    HomeView()
                        .environmentObject(authViewModel)
                        .environmentObject(schoolViewModel)
                        .onAppear {
                            // Cargar datos del estudiante autenticado
                            if let student = authViewModel.currentStudent {
                                schoolViewModel.loadData(for: student)
                            }
                        }
                } else {
                    // Show login when not authenticated
                    LoginView()
                        .environmentObject(authViewModel)
                        .environmentObject(schoolViewModel)
                }
            }
            .onChange(of: authViewModel.currentStudent) { oldValue, newValue in
                // Cuando cambie el estudiante (después del login), cargar sus datos
                if let student = newValue {
                    schoolViewModel.loadData(for: student)
                }
            }
        }
    }
}
