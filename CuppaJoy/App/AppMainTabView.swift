//
//  TabBar.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct AppMainTabView: View {
  @State private var selectedTab: Tab = .home
  
  var body: some View {
    TabView(selection: $selectedTab) {
      HomeScreen()
        .tag(Tab.home)
        .tabItem {
          Label("Home", systemImage: "storefront.fill")
        }
      MyOrdersScreen(selectedTab: $selectedTab)
        .tag(Tab.myOrders)
        .tabItem {
          Label("My Orders", systemImage: "list.bullet")
        }
      GeneralScreen()
        .tag(Tab.general)
        .tabItem {
          Label("General", systemImage: "gearshape")
        }
    }
    .onChange(of: selectedTab) {
      let generator = UIImpactFeedbackGenerator(style: .soft)
      generator.impactOccurred()
    }
  }
}

enum Tab {
  case home, myOrders, general
}

#Preview {
  AppMainTabView()
    .environmentObject(AuthViewModel())
    .environmentObject(CoffeeCatalogViewModel())
    .environmentObject(OrderViewModel())
    .environmentObject(CoffeeConfigViewModel())
}
