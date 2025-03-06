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
      Color.appBackground.ignoresSafeArea(.all)
      VStack {
        HomeHeaderView()
        CoffeeSelectionContainer()
      }
    }
  }
}

#Preview {
  HomeScreen()
    .environmentObject( AuthenticationViewModel() )
    .environmentObject( CoffeeViewModel() )
}
