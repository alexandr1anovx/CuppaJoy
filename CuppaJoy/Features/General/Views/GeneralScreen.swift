//
//  GeneralScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 31.03.2025.
//

import SwiftUI

enum SettingsPageContent: Hashable {
  case settings
  case editProfile
}

struct GeneralScreen: View {
  
  @State private var isShownSignOutAlert = false
  @State private var isShownTabBar = true
  @State private var path = NavigationPath()
  
  @EnvironmentObject var sessionManager: SessionManager
  let userService: UserServiceProtocol
  let authService: AuthServiceProtocol
  
  var body: some View {
    NavigationStack(path: $path) {
      ZStack {
        Color.appBackgroundDimmed.ignoresSafeArea()
        VStack {
          if let user = sessionManager.currentUser {
            HStack(spacing: 15) {
              StaticProfileImageView()
                .shadow(radius: 3)
              VStack(alignment: .leading, spacing: 10) {
                Text(user.fullName)
                  .foregroundStyle(.white)
                  .font(.headline)
                  .fontWeight(.bold)
                Text(user.email)
                  .font(.caption)
                  .fontWeight(.medium)
                  .foregroundStyle(.gray)
              }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top)
            .padding(.horizontal,20)
          } else {
            ProgressView("Loading...")
          }
          
          List {
            // Settings Button
            NavigationLink(value: SettingsPageContent.settings) {
              CustomListCell(for: .settings)
            }
            // Sign Out Button
            Button {
              isShownSignOutAlert = true
            } label: {
              CustomListCell(for: .signOut)
            }
          }
          .customListStyle(minRowHeight: 60, rowSpacing: 10, shadow: 5)
        }
      }
      .navigationTitle("General")
      .navigationBarTitleDisplayMode(.large)
      .navigationDestination(for: SettingsPageContent.self) { page in
        switch page {
        case .settings:
          SettingsScreen(
            path: $path, isShownTabBar: $isShownTabBar
          )
        case .editProfile:
          ProfileScreen(
            path: $path,
            isShownTabBar: $isShownTabBar,
            viewModel: ProfileViewModel(
              sessionManager: sessionManager,
              authService: authService,
              userService: userService
            )
          )
        }
      }
      .toolbar(isShownTabBar ? .visible : .hidden, for: .tabBar)
      .alert("Sign Out", isPresented: $isShownSignOutAlert) {
        Button("Sign Out", role: .destructive) {
          do {
            try authService.signOut()
          } catch {
            print("Failed to log out")
          }
        }
      } message: {
        Text("Are you sure you want to sign out?")
      }
    }
  }
}
