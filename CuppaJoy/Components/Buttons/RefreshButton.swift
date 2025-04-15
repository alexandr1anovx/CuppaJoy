//
//  RefreshAnimatedView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 14.04.2025.
//

import SwiftUI

struct RefreshButton: View {
  @State private var isAnimating = false
  @State private var rotation = 0.0
  var action: () -> Void
  
  var body: some View {
    Button {
      action() // Calls the passed method.
      isAnimating = true
      withAnimation { rotation += 720 }
      
      // Returns the button to its original state after 2 seconds.
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        withAnimation { isAnimating = false }
      }
    } label: {
      Image(systemName: "arrow.clockwise.circle.fill")
        .rotationEffect(.degrees(rotation))
        .animation(.easeInOut(duration: 3), value: rotation)
        .foregroundStyle(.orange)
        .padding(13)
        .background(.csDarkGrey)
        .clipShape(.capsule)
    }
  }
}


#Preview {
  RefreshButton{}
}
