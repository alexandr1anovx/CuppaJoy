//
//  TabBar.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

enum Tab: String, Hashable {
  case home
  case rewards
  case history
  
  var title: String { self.rawValue.capitalized }
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
        OrderTabScreen()
          .tag(Tab.history)
          .tabItem {
            Image(.bookmark)
            Text("Orders")
          }
      }
      .navigationTitle(selectedTab.title)
    }
  }
}

#Preview {
  EntryPoint()
}
