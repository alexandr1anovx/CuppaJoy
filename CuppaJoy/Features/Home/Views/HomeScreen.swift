//
//  HomeScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.10.2024.
//

import SwiftUI

enum OrderPage: Hashable {
  case configurator(Coffee)
  case summary(Order)
  case payment(Order)
}

struct HomeScreen: View {
  @State private var path = NavigationPath()
  @State private var isTabBarVisible = true
  
  var body: some View {
    NavigationStack(path: $path) {
      ZStack {
        Color.appBackground.ignoresSafeArea(.all)
        VStack {
          HomeHeaderView()
            .padding(.vertical, 30)
            .padding(.horizontal, 15)
          CoffeeSelectionView(
            path: $path,
            isTabBarVisible: $isTabBarVisible
          )
        }
      }
      .navigationTitle("Home")
      .navigationBarTitleDisplayMode(.large)
      .navigationDestination(for: OrderPage.self) { page in
        switch page {
        case .configurator(let coffee):
          OrderConfiguratorScreen(
            selectedCoffee: coffee,
            path: $path,
            isTabBarVisible: $isTabBarVisible
          )
        case .summary(let order):
          OrderSummaryScreen(order: order, path: $path)
        case .payment(let order):
          OrderPaymentScreen(
            order: order,
            isTabBarVisible: $isTabBarVisible,
            path: $path
          )
        }
      }
      .toolbar(isTabBarVisible ? .visible : .hidden, for: .tabBar)
    }
  }
}

#Preview {
  HomeScreen()
    .environmentObject(AuthViewModel.previewMode())
    .environmentObject(CoffeeCatalogViewModel.previewMode())
    .environmentObject(CoffeeConfigViewModel())
}
