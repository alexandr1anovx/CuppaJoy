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
          Image(systemName: "storefront.fill")
          Text("Home")
        }
      MyOrdersScreen(selectedTab: $selectedTab)
        .tag(Tab.myOrders)
        .tabItem {
          Image(systemName: "list.bullet")
          Text("My Orders")
        }
      GeneralScreen()
        .tag(Tab.general)
        .tabItem {
          Image(systemName: "gearshape")
          Text("General")
        }
    }
    .onChange(of: selectedTab) {
      let generator = UIImpactFeedbackGenerator(style: .soft)
      generator.impactOccurred()
    }
  }
}

enum Tab {
  case home
  case myOrders
  case general
}

#Preview {
  AppMainTabView()
    .environmentObject(AuthViewModel.previewMode())
    .environmentObject(CoffeeViewModel.previewMode())
    .environmentObject(OrderViewModel.previewMode())
}
