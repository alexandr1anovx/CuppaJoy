//
//  LaunchScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 23.03.2025.
//

import SwiftUI

struct LaunchScreen: View {
  
  @State private var isShownContent = false
  @EnvironmentObject var authViewModel: AuthViewModel
  @EnvironmentObject var coffeeViewModel: CoffeeViewModel
  
  var body: some View {
    Group {
      if authViewModel.userSession != nil {
        if isShownContent {
          EntryPoint()
        } else {
          logoImageBackground
        }
      } else {
        SignInScreen()
      }
    }
    .onAppear {
      coffeeViewModel.getCoffees()
      DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        withAnimation(.spring(duration: 1)) {
          isShownContent.toggle()
        }
      }
    }
  }
  
  private var logoImageBackground: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      Image(systemName: "hand.raised")
    }
  }
}

#Preview {
  LaunchScreen()
    .environmentObject(AuthViewModel())
    .environmentObject(CoffeeViewModel())
}
