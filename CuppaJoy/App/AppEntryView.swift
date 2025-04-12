//
//  AppEntryView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.04.2025.
//

import SwiftUI

struct AppEntryView: View {
  @State private var isShownAppContent = false
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    Group {
      if authViewModel.userSession != nil {
        if isShownAppContent {
          MainTabView()
        } else {
          LaunchScreen()
        }
      } else {
        SignInScreen()
      }
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
        withAnimation {
          isShownAppContent.toggle()
        }
      }
    }
  }
}

#Preview {
  AppEntryView()
}
