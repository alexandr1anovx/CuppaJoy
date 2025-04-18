//
//  SettingsScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.04.2025.
//

import SwiftUI

enum ColorTheme: String, Identifiable, CaseIterable {
  case system
  case light
  case dark
  
  var id: Self { self }
  var title: String { rawValue.capitalized }
}

struct SettingsScreen: View {
  @Binding var path: NavigationPath
  @Binding var isShownTabBar: Bool
  @State private var selectedTheme: ColorTheme = .system
  
  var body: some View {
    ZStack {
      Color.csBlack.ignoresSafeArea(.all)
      VStack {
        List {
          // Appearance Section
          Section("Appearance") {
            Picker("", selection: $selectedTheme) {
              ForEach(ColorTheme.allCases) { theme in
                Text(theme.title)
              }
            }.pickerStyle(.segmented)
          }
          
          // Profile Section
          Section("Profile") {
            NavigationLink(value: SettingsPageContent.editProfile) {
              CustomListCell(for: .editProfile)
            }
          }
        }
        .customListStyle(rowSpacing: 10, shadowRadius: 3)
        .listSectionSpacing(10)
      }
    }
    .onAppear {
      isShownTabBar = false
      setupSegmentedControlAppearance()
    }
    .navigationTitle("Settings")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button {
          path.removeLast()
          isShownTabBar = true
        } label: {
          ReturnButtonLabel()
        }
      }
    }
  }
}

#Preview {
  SettingsScreen(
    path: .constant(NavigationPath()),
    isShownTabBar: .constant(false)
  )
}
