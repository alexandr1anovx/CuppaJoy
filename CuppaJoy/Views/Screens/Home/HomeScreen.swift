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
      
      VStack {
        HomeHeaderView()
          .padding(.top,5)
        CoffeeSelectionView()
          .shadow(radius: 5)
          .padding(.horizontal)
          .padding(.bottom)
      }
    }
    .toolbar(.hidden, for: .navigationBar)
  }
}

#Preview {
  HomeScreen()
}
