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
      DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
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
