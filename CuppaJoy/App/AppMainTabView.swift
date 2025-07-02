//
//  TabBar.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

enum Tab {
  case home, myOrders, general
}

struct AppMainTabView: View {
  @State private var selectedTab: Tab = .home
  @EnvironmentObject var sessionManager: SessionManager
  @StateObject var orderViewModel: OrderViewModel
  
  let authService: AuthServiceProtocol
  let userService: UserServiceProtocol
  let coffeeConfigService: CoffeeConfigServiceProtocol
  
  init(
    sessionManager: SessionManager,
    authService: AuthServiceProtocol,
    userService: UserServiceProtocol,
    coffeeConfigService: CoffeeConfigServiceProtocol
  ) {
    _orderViewModel = StateObject(
      wrappedValue: OrderViewModel(sessionManager: sessionManager)
    )
    self.authService = authService
    self.userService = userService
    self.coffeeConfigService = coffeeConfigService
  }
  
  var body: some View {
    TabView(selection: $selectedTab) {
      HomeScreen(coffeeConfigService: coffeeConfigService)
        .tag(Tab.home)
        .tabItem {
          Label("Home", systemImage: "storefront.fill")
        }
      MyOrdersScreen(selectedTab: $selectedTab, sessionManager: sessionManager)
        .tag(Tab.myOrders)
        .tabItem {
          Label("My Orders", systemImage: "list.bullet")
        }
      GeneralScreen(userService: userService, authService: authService)
        .tag(Tab.general)
        .tabItem {
          Label("General", systemImage: "gearshape")
        }
    }
    .environmentObject(orderViewModel)
    .onChange(of: selectedTab) {
      let generator = UIImpactFeedbackGenerator(style: .soft)
      generator.impactOccurred()
    }
  }
}
