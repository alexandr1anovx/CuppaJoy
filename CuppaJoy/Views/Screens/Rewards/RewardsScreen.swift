//
//  RewardsScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.10.2024.
//

import SwiftUI

struct RewardsScreen: View {
  var body: some View {
    ZStack {
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      Text("Rewards Screen")
        .font(.poppins(.medium, size: 25))
    }
  }
}

#Preview {
  RewardsScreen()
}
