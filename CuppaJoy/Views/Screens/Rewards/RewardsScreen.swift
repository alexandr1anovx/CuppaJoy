//
//  RewardsScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.10.2024.
//

import SwiftUI

struct RewardsScreen: View {
    @Binding var isShownTabBar: Bool
    
    var body: some View {
        ZStack {
            Color.primarySystem.ignoresSafeArea()
            VStack {
                Image("rewards")
                Text("Rewards")
                    .font(.poppins(.medium, size: 25))
            }
        }
    }
}

#Preview {
    RewardsScreen(isShownTabBar: .constant(true))
}
