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
  
  @Binding var generalScreenPath: NavigationPath
  @Binding var isTabBarVisible: Bool
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
            }
            .padding(.vertical, 5)
            .pickerStyle(.segmented)
          }
          
          // Profile Section
          Section("Profile") {
            NavigationLink(value: SettingsPageContent.editProfile) {
              CustomListCell(for: .editProfile)
            }
          }
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(10)
        .listRowSpacing(10)
        .scrollContentBackground(.hidden)
        .shadow(radius: 3)
      }
    }
    .onAppear { isTabBarVisible = false }
    .navigationTitle("Settings")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          isTabBarVisible = true
          generalScreenPath.removeLast()
        } label: {
          ButtonLabelReturn()
        }
      }
    }
  }
}

#Preview {
  SettingsScreen(
    generalScreenPath: .constant(NavigationPath()),
    isTabBarVisible: .constant(false)
  )
}
