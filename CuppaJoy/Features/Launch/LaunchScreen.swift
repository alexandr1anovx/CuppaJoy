//
//  LaunchScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.04.2025.
//

import SwiftUI

struct LaunchScreen: View {
  @EnvironmentObject var coffeeViewModel: CoffeeViewModel
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      HStack {
        Text("Launching")
          .font(.title2)
          .fontWeight(.semibold)
          .fontDesign(.serif)
        ProgressView()
      }
    }
    .onAppear {
      coffeeViewModel.getCoffees()
    }
  }
}

#Preview {
  LaunchScreen()
}
