//
//  HomeScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.10.2024.
//

import SwiftUI

struct HomeScreen: View {
  @Binding var isTabBarVisible: Bool
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.mainBackgroundGradient.ignoresSafeArea()
        
        VStack(alignment: .leading, spacing: 25) {
          HomeHeaderView()
          CoffeeSelectionView()
            .shadow(radius: 5)
        }
      }
      .onAppear { isTabBarVisible = true }
    }
  }
}

#Preview {
  HomeScreen(isTabBarVisible: .constant(true))
}
