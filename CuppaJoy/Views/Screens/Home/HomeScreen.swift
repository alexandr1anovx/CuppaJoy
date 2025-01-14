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
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 25) {
        HomeHeaderView()
        CoffeeSelectionView()
          .shadow(radius: 5)
      }
    }
    .toolbar(.hidden, for: .navigationBar)
  }
}

#Preview {
  HomeScreen()
}
