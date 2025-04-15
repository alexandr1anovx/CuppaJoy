//
//  TabBar.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct AppMainTabView: View {
  
  @State private var selectedTab: Tab = .home
  let generator = UIImpactFeedbackGenerator(style: .soft)
  
  var body: some View {
    TabView(selection: $selectedTab) {
      HomeScreen()
        .tag(Tab.home)
        .tabItem {
          Image(systemName: Tab.home.image)
          Text(Tab.home.title)
        }
      MyOrdersScreen(selectedTab: $selectedTab)
        .tag(Tab.orders)
        .tabItem {
          Image(systemName: Tab.orders.image)
          Text(Tab.orders.title)
        }
      GeneralScreen()
        .tag(Tab.general)
        .tabItem {
          Image(systemName: Tab.general.image)
          Text(Tab.general.title)
        }
    }
    .onChange(of: selectedTab) {
      generator.impactOccurred()
    }
  }
}

enum Tab: String {
  case home
  case orders
  case general
  
  var id: String { rawValue }
  var title: String { rawValue.capitalized }
  var image: String {
    switch self {
    case .home: "storefront.fill"
    case .orders: "list.bullet"
    case .general: "gearshape"
    }
  }
}

#Preview {
  AppMainTabView()
    .environmentObject(AuthViewModel.previewMode())
    .environmentObject(CoffeeViewModel.previewMode())
    .environmentObject(OrderViewModel())
}
