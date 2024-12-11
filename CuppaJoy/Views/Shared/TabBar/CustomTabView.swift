//
//  TabBar.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct CustomTabView: View {
  @State private var selectedTab = TabItem.home
  @State private var isTabBarVisible = true
  
  init() {
    UITabBar.appearance().isHidden = true
  }
  
  var body: some View {
    ZStack(alignment: .bottom) {
      
      TabView(selection: $selectedTab) {
        HomeScreen(isTabBarVisible: $isTabBarVisible)
          .tag(TabItem.home)
        MyRewardsScreen(isTabBarVisible: $isTabBarVisible)
          .tag(TabItem.rewards)
        MyOrdersScreen(isTabBarVisible: $isTabBarVisible)
          .tag(TabItem.orders)
      }
      
      if isTabBarVisible {
        CustomTabBar(selectedTab: $selectedTab)
      }
    }
  }
}

#Preview {
  CustomTabView()
}
