//
//  AppEntryView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.04.2025.
//

import SwiftUI

struct RootView: View {
  
  @State private var showLoadingAnimation = true
  @StateObject var sessionManager: SessionManager
  
  let authService: AuthServiceProtocol
  let userService: UserServiceProtocol
  let coffeeConfigService: CoffeeConfigServiceProtocol
  let remoteConfigService: RemoteConfigServiceProtocol
  
  var body: some View {
    Group {
      switch sessionManager.sessionState {
      
      case .signedIn(_):
        if showLoadingAnimation {
          LaunchScreen()
        } else {
          AppMainTabView(
            sessionManager: sessionManager,
            authService: authService,
            userService: userService,
            coffeeConfigService: coffeeConfigService,
            remoteConfigService: remoteConfigService
          )
        }
      case .signedOut:
        LoginScreen(
          authService: authService,
          userService: userService,
          viewModel: LoginViewModel(authService: authService)
        )
      }
    }
    .animation(.easeInOut, value: sessionManager.sessionState)
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
        showLoadingAnimation = false
      }
    }
  }
}
