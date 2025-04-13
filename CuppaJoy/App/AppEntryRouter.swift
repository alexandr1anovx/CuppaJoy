//
//  AppEntryView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.04.2025.
//

import SwiftUI

struct AppEntryRouter: View {
  
  @State private var isShownAppContent = false
  @EnvironmentObject var authViewModel: AuthViewModel
  @EnvironmentObject var coffeeViewModel: CoffeeViewModel
  
  var body: some View {
    Group {
      if UserDefaults.standard.isFirstLaunch {
        OnboardingScreen()
      } else if authViewModel.userSession != nil {
        if isShownAppContent {
          AppMainTabView()
        } else {
          LaunchScreen()
        }
      } else {
        SignInScreen()
      }
    }
    .onAppear {
      coffeeViewModel.getCoffees()
      
      DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
        withAnimation {
          isShownAppContent.toggle()
        }
      }
    }
  }
}

#Preview {
  AppEntryRouter()
}
