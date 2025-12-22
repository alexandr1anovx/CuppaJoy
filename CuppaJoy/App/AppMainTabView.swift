//
//  TabBar.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

enum Tab {
  case home
  case orders
  case general
}

struct AppMainTabView: View {
  
  @State private var selectedTab: Tab = .home
  @State var orderViewModel: OrderViewModel
  let authService: AuthServiceProtocol
  let userService: UserServiceProtocol
  let coffeeRecipeService: CoffeeRecipeServiceProtocol
  let remoteConfigService: RemoteConfigServiceProtocol
  
  init(
    sessionManager: SessionManager,
    authService: AuthServiceProtocol,
    userService: UserServiceProtocol,
    coffeeRecipeService: CoffeeRecipeServiceProtocol,
    remoteConfigService: RemoteConfigServiceProtocol
  ) {
    _orderViewModel = State(wrappedValue: OrderViewModel(sessionManager: sessionManager))
    self.authService = authService
    self.userService = userService
    self.coffeeRecipeService = coffeeRecipeService
    self.remoteConfigService = remoteConfigService
  }
  
  var body: some View {
    TabView(selection: $selectedTab) {
      HomeScreen(
        coffeeRecipeService: coffeeRecipeService,
        remoteConfigService: remoteConfigService
      )
      .tag(Tab.home)
      .tabItem {
        Label("Home", systemImage: "storefront.fill")
      }
      MyOrdersScreen(selectedTab: $selectedTab)
        .tag(Tab.orders)
        .tabItem {
          Label("Orders", systemImage: "list.bullet.clipboard.fill")
        }
      GeneralScreen(
        userService: userService,
        authService: authService,
        remoteConfigService: remoteConfigService
      )
      .tag(Tab.general)
      .tabItem {
        Label("General", systemImage: "line.3.horizontal")
      }
    }
    .environment(orderViewModel)
    .onChange(of: selectedTab) {
      let generator = UIImpactFeedbackGenerator(style: .soft)
      generator.impactOccurred()
    }
  }
}
