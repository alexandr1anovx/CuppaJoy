//
//  CustomListCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.04.2025.
//

import SwiftUI

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
      case .settings: Color.csCream
      case .editProfile: Color.csCream
      case .rateUS: Color.csCream
      case .signOut: Color.red
      case .deleteAccount: Color.red
      }
    }
  }
}
