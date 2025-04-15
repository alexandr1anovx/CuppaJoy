//
//  GeneralScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 31.03.2025.
//

import SwiftUI
import StoreKit

enum SettingsPageContent: Hashable {
  case settings
  case editProfile
}

struct GeneralScreen: View {
  
  @State private var isShownSignOutAlert = false
  @State private var isShownTabBar = true
  @State private var generalScreenPath = NavigationPath()
  @Environment(\.requestReview) var requestReview
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    NavigationStack(path: $generalScreenPath) {
      ZStack {
        Color.csBlack
          .ignoresSafeArea(.all)
        VStack(spacing: 10) {
          
          // Check whether the user data is shown
          // Otherwise shown a progress view
          if let user = authViewModel.currentUser {
            HStack(spacing: 15) {
              StaticProfileImageView().shadow(radius: 3)
              VStack(alignment: .leading, spacing: 10) {
                Text(user.fullName)
                  .foregroundStyle(.white)
                  .font(.headline)
                  .fontWeight(.bold)
                Text(user.emailAddress)
                  .font(.caption)
                  .fontWeight(.medium)
                  .foregroundStyle(.gray)
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
            .padding(.horizontal,20)
          } else {
            VStack{
              ProgressView()
              Text("Data is loading...")
              Text("Please, wait a bit.")
            }
          }
          
          List {
            // Settings Button
            NavigationLink(value: SettingsPageContent.settings) {
              CustomListCell(for: .settings)
            }
            // RateUs Button
            Button {
              requestReview()
            } label: {
              CustomListCell(for: .rateUS)
            }
            // SignOut Button
            Button {
              isShownSignOutAlert = true
            } label: {
              CustomListCell(for: .signOut)
            }
          }
          .listStyle(.insetGrouped)
          .listRowSpacing(10)
          .scrollContentBackground(.hidden)
          .environment(\.defaultMinListRowHeight, 60)
          .shadow(radius: 3)
        }
      }
      .navigationTitle("General")
      .navigationBarTitleDisplayMode(.large)
      .navigationDestination(for: SettingsPageContent.self) { page in
        switch page {
        case .settings:
          SettingsScreen(
            generalScreenPath: $generalScreenPath,
            isShownTabBar: $isShownTabBar
          )
        case .editProfile:
          ProfileScreen(
            isShownTabBar: $isShownTabBar,
            generalScreenPath: $generalScreenPath
          )
        }
      }
      .toolbar(isShownTabBar ? .visible : .hidden, for: .tabBar)
      
      .alert("Sign Out", isPresented: $isShownSignOutAlert) {
        Button("Sign Out", role: .destructive) {
          withAnimation(.easeInOut(duration: 1)) {
            authViewModel.signOut()
          }
        }
      } message: {
        Text("Are you sure you want to sign out?")
      }
    }
  }
}

#Preview {
  GeneralScreen()
    .environmentObject(AuthViewModel.previewMode())
}
