//
//  BlossomApp.swift
//  Blossom


import SwiftUI
import FirebaseCore


@main
struct BlossomApp: App {
    // Used to link the AppDelegate class to the Blossom App
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
           RootView()
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

// Used to Configure Firebase in an iOS app's AppDelegate class, so that the app can use Firebase services to provide features and functionality to users.
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      print("Configured Firebase")
    return true
  }
}
