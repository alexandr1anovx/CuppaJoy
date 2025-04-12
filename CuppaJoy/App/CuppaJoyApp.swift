//
//  CuppaJoyApp.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct CuppaJoyApp: App {
  @StateObject private var orderViewModel = OrderViewModel()
  @StateObject private var authViewModel = AuthViewModel()
  @StateObject private var coffeeViewModel = CoffeeViewModel()
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
  var body: some Scene {
    WindowGroup {
      AppEntryView()
        .preferredColorScheme(.dark)
        .environmentObject(orderViewModel)
        .environmentObject(authViewModel)
        .environmentObject(coffeeViewModel)
        
    }
  }
}
