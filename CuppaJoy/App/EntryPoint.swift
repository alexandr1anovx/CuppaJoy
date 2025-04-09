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
  let generator = UIImpactFeedbackGenerator(style: .medium)
  
  var body: some View {
    TabView(selection: $selectedTab) {
      HomeScreen()
        .tag(Tab.home)
        .tabItem {
          Image(systemName: "house")
          Text("Home")
        }
      MyOrdersScreen(selectedTab: $selectedTab)
        .tag(Tab.orders)
        .tabItem {
          Image(systemName: "list.bullet")
          Text("Orders")
        }
      GeneralScreen()
        .tag(Tab.settings)
        .tabItem {
          Image(systemName: "gearshape")
          Text("General")
        }
    }
    .onChange(of: selectedTab) {
      generator.impactOccurred()
    }
  }
}

#Preview {
  EntryPoint()
    .environmentObject( OrderViewModel() )
    .environmentObject( CoffeeViewModel.previewMode() )
    .environmentObject( AuthViewModel.previewMode() )
}
