//
//  TabBar.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

enum Tab {
  case home, rewards, orders
}

struct EntryPoint: View {
  @State private var selectedTab: Tab = .home
  
  var body: some View {
    NavigationStack {
      TabView(selection: $selectedTab) {
        HomeScreen()
          .tag(Tab.home)
          .tabItem {
            Image(.home)
            Text("Home")
          }
        RewardsScreen()
          .tag(Tab.rewards)
          .tabItem {
            Image(.gift)
            Text("Rewards")
          }
        OrderStatusScreen()
          .tag(Tab.orders)
          .tabItem {
            Image(.bookmark)
            Text("Orders")
          }
      }
      // Enables haptic feedback when selecting a tab.
      .onChange(of: selectedTab) {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
      }
    }
  }
}

#Preview {
  EntryPoint()
}
