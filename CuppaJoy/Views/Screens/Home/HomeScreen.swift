//
//  HomeScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.10.2024.
//

import SwiftUI

struct HomeScreen: View {
  var body: some View {
    ZStack {
      Color.mainGradientBackground.ignoresSafeArea()

      VStack {
        HomeHeaderView()
        CoffeeSelectionView()
          .shadow(radius: 5)
          .padding(.horizontal)
          .padding(.bottom)
      }
    }
  }
}

#Preview {
  HomeScreen()
}
