//
//  HomeHeader.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

struct HomeHeaderView: View {
  @EnvironmentObject var sessionManager: SessionManager
  
  var body: some View {
    HStack(spacing: 12) {
      if let user = sessionManager.currentUser {
        Image(systemName: "person.fill")
          .imageScale(.large)
          .foregroundStyle(.white)
          .padding(10)
          .background(.csDarkGrey)
          .clipShape(.circle)
        
        VStack(alignment: .leading, spacing: 10) {
          Text(user.fullName)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.primary)
            .lineLimit(2)
          
          HStack(spacing: 6) {
            Image(.star)
              .resizable()
              .frame(width: UIConstants.Sizes.smallIcon, height: UIConstants.Sizes.smallIcon)
            Text(user.stringCoins)
              .font(.footnote)
              .fontWeight(.semibold)
          }
          .foregroundStyle(.orange)
          .padding(8)
          .background(.csDarkGrey)
          .clipShape(.capsule)
        }
        Spacer()
        CapsuleLabel(user.city, textColor: .accent, bgColor: .csDarkGrey)
      } else {
        VStack(alignment: .leading, spacing: 10) {
          Text("Name Surname")
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(.primary)
            .lineLimit(2)
          
          HStack(spacing: 6) {
            Image(.star)
              .resizable()
              .frame(width: UIConstants.Sizes.smallIcon, height: UIConstants.Sizes.smallIcon)
            Text("150")
              .font(.footnote)
              .fontWeight(.semibold)
          }
          .foregroundStyle(.orange)
          .padding(8)
          .background(.csDarkGrey)
          .clipShape(.capsule)
        }
        
        Spacer()
        
        CapsuleLabelCompact("Odesa", textColor: .accent, bgColor: .csDarkGrey)
      }
    }
  }
}

#Preview {
  HomeHeaderView()
    .environmentObject(SessionManager(userService: UserService()))
}
