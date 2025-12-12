//
//  Ordinario_iOSApp.swift
//  Ordinario_iOS
//
//  Created by Eduardo Pérez Córdova on 03/12/25.
//

import SwiftUI
import Firebase

// Firebase AppDelegate
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
}

@main
struct Ordinario_iOSApp: App {
    
    // Registrar el AppDelegate para inicializar Firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // ViewModels
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject private var schoolViewModel = SchoolViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                // Show main app when authenticated
                HomeView()
                    .environmentObject(authViewModel)
                    .environmentObject(schoolViewModel)
            } else {
                // Show login when not authenticated
                LoginView()
                    .environmentObject(authViewModel)
                    .environmentObject(schoolViewModel)
            }
        }
    }
}
