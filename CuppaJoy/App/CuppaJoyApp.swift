//
//  CuppaJoyApp.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct CuppaJoyApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  @StateObject private var orderViewModel = OrderViewModel()
  @StateObject private var authViewModel = AuthViewModel()
  @StateObject private var coffeeCatalogViewModel = CoffeeCatalogViewModel()
  @StateObject private var coffeeConfigViewModel = CoffeeConfigViewModel()
  
  var body: some Scene {
    WindowGroup {
      AppEntryRouter()
        .preferredColorScheme(.dark)
        .environmentObject(orderViewModel)
        .environmentObject(authViewModel)
        .environmentObject(coffeeCatalogViewModel)
        .environmentObject(coffeeConfigViewModel)
    }
  }
}
