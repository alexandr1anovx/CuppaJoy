//
//  CuppaJoyApp.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI
import Firebase

@main
struct CuppaJoyApp: App {
  @StateObject private var coffeeCatalogViewModel = CoffeeCatalogViewModel()
  @StateObject private var sessionManager: SessionManager

  private let authService: AuthServiceProtocol
  private let userService: UserServiceProtocol
  private let coffeeConfigService: CoffeeConfigServiceProtocol

  init() {
    FirebaseApp.configure()
    let authService = AuthService()
    let userService = UserService()
    let coffeeConfigService = CoffeeConfigService()
    self.authService = authService
    self.userService = userService
    self.coffeeConfigService = coffeeConfigService
    _sessionManager = StateObject(
      wrappedValue: SessionManager(userService: userService)
    )
  }
  
  var body: some Scene {
    WindowGroup {
      RootView(
        sessionManager: sessionManager,
        authService: authService,
        userService: userService,
        coffeeConfigService: coffeeConfigService
      )
      .preferredColorScheme(.dark)
      .environmentObject(sessionManager)
      .environmentObject(coffeeCatalogViewModel)
    }
  }
}
