//
//  GeneralScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 31.03.2025.
//

import SwiftUI

enum SettingsPageContent: Hashable {
  case settings
}

struct GeneralScreen: View {
  @State private var path = NavigationPath()

  var body: some View {
    NavigationStack(path: $path) {
      ZStack {
        Color.appBackground.ignoresSafeArea(.all)
        VStack(spacing: 10) {
          
          // Fullname and email address
          VStack(spacing: 10){
            ProfileImageView()
            Text("Name and Surname")
              .foregroundStyle(.white)
              .font(.headline)
              .fontWeight(.bold)
              .padding(.top,8)
            Text("example@example.com")
              .font(.subheadline)
              .fontWeight(.medium)
          }.padding(.top)
          
          List {
            
            // Settings
            NavigationLink(value: SettingsPageContent.settings) {
              CustomListCell(for: .settings)
            }
            
            // Rate Us
            Button {
              
            } label: {
              CustomListCell(for: .rateUS)
            }
            
            // Sign Out
            Button {
              
            } label: {
              CustomListCell(for: .signOut)
            }
          }
          .listStyle(.insetGrouped)
          .listRowSpacing(10)
          .scrollContentBackground(.hidden)
          .environment(\.defaultMinListRowHeight, 60)
          .shadow(radius: 1)
        }
      }//ZStack
      .navigationTitle("General")
      .navigationBarTitleDisplayMode(.large)
      .navigationDestination(for: SettingsPageContent.self) { page in
        switch page {
        case .settings: SettingsScreen()
        }
      }
    }
  }
}

#Preview {
  GeneralScreen()
}

struct CustomListCell: View {
  let item: ListItem
  
  init(for item: ListItem) {
    self.item = item
  }
  
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: item.iconName)
        .font(.title3)
        .foregroundStyle(item.iconColor)
      
      VStack(alignment: .leading, spacing:5) {
        Text(item.title)
          .font(.callout)
          .fontWeight(.semibold)
          .foregroundStyle(.white)
        Text(item.subtitle)
          .font(.caption)
          .foregroundStyle(.gray)
      }
    }
  }
  
  enum ListItem: Hashable {
    case editProfile
    case settings
    case signOut
    case rateUS
    case deleteAccount
    
    var title: String {
      switch self {
      case .editProfile: "Edit Profile"
      case .settings: "Settings"
      case .signOut: "Sign Out"
      case .rateUS: "Rate Us"
      case .deleteAccount: "Delete Account"
      }
    }
    
    var subtitle: String {
      switch self {
      case .editProfile: "Customize your data."
      case .settings: "Customize your data."
      case .signOut: "Sign out from the current account."
      case .rateUS: "Help people to know about us."
      case .deleteAccount: "This will delete all of your data."
      }
    }
    
    var iconName: String {
      switch self {
      case .editProfile: "person.circle.fill"
      case .settings: "gearshape"
      case .signOut: "door.left.hand.open"
      case .rateUS: "hand.thumbsup.fill"
      case .deleteAccount:
        "person.crop.circle.fill.badge.xmark"
      }
    }
    
    var iconColor: Color {
      switch self {
      case .editProfile: Color.brown
      case .settings: Color.primary
      case .signOut: Color.red
      case .rateUS: Color.orange
      case .deleteAccount: Color.red
      }
    }
  }
}
