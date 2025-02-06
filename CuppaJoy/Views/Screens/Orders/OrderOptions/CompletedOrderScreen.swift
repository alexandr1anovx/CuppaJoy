//
//  CompletedOrderScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 27.10.2024.
//

import SwiftUI

struct CompletedOrderScreen: View {
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      VStack(spacing: 15) {
        Image(.onboardingDelivery)
          .resizable()
          .frame(width: 130, height: 130)
          .foregroundStyle(.accent)
        
        Text("Order received!")
          .font(.headline)
          .fontDesign(.monospaced)
          .foregroundStyle(.white)
        
        VStack(alignment: .center, spacing: 10) {
          HStack(spacing: 5) {
            Text("Address:")
              .font(.footnote)
              .fontDesign(.monospaced)
              .foregroundStyle(.gray)
            Text("Soborna Street, 50A.")
              .font(.footnote).bold()
              .fontDesign(.monospaced)
              .foregroundStyle(.accent)
          }
          
          Text("We will call you as soon as the courier arrives at the specified location.")
            .font(.caption)
            .fontDesign(.monospaced)
            .foregroundStyle(.gray)
            .multilineTextAlignment(.center)
            .padding(25)
        }
      }
    }
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        ReturnButton()
      }
    }
  }
}

#Preview {
  CompletedOrderScreen()
}
