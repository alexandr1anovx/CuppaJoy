//
//  LaunchScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.04.2025.
//

import SwiftUI

struct LaunchScreen: View {
  @State private var isAnimating = false
  @State private var rotation = 0.0
  
  var body: some View {
    ZStack {
      Color.appBackgroundDimmed.ignoresSafeArea()
      HStack(spacing: isAnimating ? 0:10) {
        Image(systemName: isAnimating ? "arrow.clockwise.circle.fill" : "cup.and.saucer.fill")
          .rotationEffect(.degrees(rotation))
          .animation(.easeInOut(duration: 3), value: rotation)
        Text(isAnimating ? "" : "CuppaJoy")
          .font(.callout)
          .fontDesign(.monospaced)
      }
      .foregroundStyle(isAnimating ? .csCream : .black)
      .padding(15)
      .background(isAnimating ? .csDarkGrey : .csCream)
      .clipShape(.capsule)
      .shadow(radius: 5)
    }
    .onAppear {
      isAnimating = true
      withAnimation { rotation += 720 }
      
      // Returns the button to its original state after 3 seconds.
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        withAnimation(.bouncy) { isAnimating = false }
      }
    }
  }
}

#Preview {
  LaunchScreen()
}
