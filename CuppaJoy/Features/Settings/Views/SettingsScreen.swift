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
  @Binding var showTabBar: Bool
  @State private var selectedTheme: ColorTheme = .system
  
  var body: some View {
    ZStack {
      Color.appBackgroundDimmed.ignoresSafeArea()
      VStack {
        Form {
          
          Section("Appearance") {
            Picker("", selection: $selectedTheme) {
              ForEach(ColorTheme.allCases) { theme in
                Text(theme.title)
              }
            }.pickerStyle(.segmented)
          }
          
          Section("Profile") {
            NavigationLink(value: SettingsPageContent.editProfile) {
              CustomListCell(for: .editProfile)
            }
          }
        }
        .customListStyle(rowSpacing: 10, sectionSpacing: 10, shadow: 3)
      }
    }
    .onAppear {
      showTabBar = false
      setupSegmentedControlAppearance()
    }
    .navigationTitle("App Settings")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button {
          path.removeLast()
          showTabBar = true
        } label: {
          BackButton()
        }
      }
    }
  }
}

#Preview {
  SettingsScreen(
    path: .constant(NavigationPath()),
    showTabBar: .constant(false)
  )
}
