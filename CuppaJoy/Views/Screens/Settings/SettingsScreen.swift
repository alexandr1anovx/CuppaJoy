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
            NavigationLink {
              ProfileScreen()
            } label: {
              CustomListCell(for: .editProfile)
            }
          }
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(10)
        .listRowSpacing(10)
        .scrollContentBackground(.hidden)
        .shadow(radius: 1)
      }
      .navigationTitle("Settings")
      .navigationBarTitleDisplayMode(.large)
    }
  }
}

#Preview {
  SettingsScreen()
}
