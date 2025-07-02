//
//  RefreshAnimatedView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 14.04.2025.
//

import SwiftUI

struct RefreshButton: View {
  @State private var isAnimating: Bool = false
  @State private var rotationDegress: Double = 0.0
  var action: () -> Void
  
  var body: some View {
    Button {
      action()
      isAnimating = true
      withAnimation { rotationDegress += 720 }
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        withAnimation { isAnimating = false }
      }
    } label: {
      Image(systemName: "arrow.clockwise.circle.fill")
        .rotationEffect(.degrees(rotationDegress))
        .animation(.easeInOut(duration: 3), value: rotationDegress)
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
