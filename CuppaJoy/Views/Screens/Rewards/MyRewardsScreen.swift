//
//  RewardsScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.10.2024.
//

import SwiftUI

struct MyRewardsScreen: View {
  @Binding var isShownTabBar: Bool
  
  var body: some View {
    ZStack {
      Color.cstDarkBrown.ignoresSafeArea()
      
    }
    /*
     .navigationTitle("Rewards")
     .navigationBarTitleDisplayMode(.inline)
     */
  }
}

struct LoyaltyCardView: View {
  var body: some View {
    VStack {
      
      RoundedRectangle(cornerRadius: 15)
        .fill(Color.cstBrown
          .shadow(.inner(color: .cstBlack, radius: 2, y: 3))
          .shadow(.drop(color: .cstBlack, radius: 3)))
        .frame(width: 345, height: 135)
        .overlay {
          
          VStack(spacing: 15) {
            HStack {
              Text("Loyalty Card")
              Spacer()
              Text("4/8")
            }
            .padding(.horizontal, 45)
            .foregroundStyle(.cstWhite)
            .font(.poppins(.medium, size: 15))
            
            RoundedRectangle(cornerRadius: 10)
              .fill(Color.cstWhite
                .shadow(.inner(color: .cstBlack, radius: 2, y: 3))
                .shadow(.drop(color: .cstBlack, radius: 3)))
              .frame(width: 270, height: 60)
              .overlay(alignment: .center) {
                HStack(spacing: 2) {
                  ForEach(0..<8) { cup in
                    Image("coffeeGlass")
                      .resizable()
                      .frame(width: 30, height: 30)
                      .foregroundStyle(.cstBlue)
                  }
                }
              }
          }
        }
    }
  }
}

#Preview {
  MyRewardsScreen(isShownTabBar: .constant(true))
}
