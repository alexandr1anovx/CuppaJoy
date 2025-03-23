//
//  TabBar.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

enum Tab {
  case home, orders, settings
}

struct EntryPoint: View {
  
  @State private var selectedTab: Tab = .home
  let generator = UIImpactFeedbackGenerator(style: .light)
  
  var body: some View {
    NavigationStack {
      TabView(selection: $selectedTab) {
        HomeScreen()
          .tag(Tab.home)
          .tabItem {
            Image(systemName: "house")
            Text("Home")
          }
        OrderStatusScreen(selectedTab: $selectedTab)
          .tag(Tab.orders)
          .tabItem {
            Image(systemName: "list.bullet")
            Text("Orders")
          }
        ProfileScreen()
          .tag(Tab.settings)
          .tabItem {
            Image(systemName: "gearshape")
            Text("Settings")
          }
      }
      // Enables haptic feedback when selecting a tab.
      .onChange(of: selectedTab) {
        generator.impactOccurred()
      }
    }
  }
}

#Preview {
  EntryPoint()
    .environmentObject( OrderViewModel() )
    .environmentObject( CoffeeViewModel() )
    .environmentObject( AuthViewModel() )
}
