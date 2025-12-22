//
//  CuppaJoyApp.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI
import Firebase
import FirebaseRemoteConfig

@main
struct CuppaJoyApp: App {
  @StateObject private var coffeeCatalogViewModel = CoffeeCatalogViewModel()
  @StateObject private var sessionManager: SessionManager

  private let authService: AuthServiceProtocol
  private let userService: UserServiceProtocol
  private let coffeeConfigService: CoffeeConfigServiceProtocol
  private let remoteConfigService: RemoteConfigServiceProtocol

  init() {
    FirebaseApp.configure()
    
    let authService = AuthService()
    let userService = UserService()
    let coffeeConfigService = CoffeeConfigService()
    let remoteConfigService = RemoteConfigService()
    
    self.authService = authService
    self.userService = userService
    self.coffeeConfigService = coffeeConfigService
    self.remoteConfigService = remoteConfigService
    
    _sessionManager = StateObject(
      wrappedValue: SessionManager(userService: userService)
    )
    
    // Initialize Remote Config
    Task {
      do {
        try await remoteConfigService.fetchAndActivate()
        print("Remote Config activated successfully")
      } catch {
        print("Failed to activate Remote Config: \(error)")
      }
    }
  }
  
  var body: some Scene {
    WindowGroup {
      RootView(
        sessionManager: sessionManager,
        authService: authService,
        userService: userService,
        coffeeConfigService: coffeeConfigService,
        remoteConfigService: remoteConfigService
      )
      .preferredColorScheme(.dark)
      .environmentObject(sessionManager)
      .environmentObject(coffeeCatalogViewModel)
    }
  }
}
