//
//  HomeHeader.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

struct HomeHeaderView: View {
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    HStack(spacing:12) {
      if let user = authViewModel.currentUser {
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
              .frame(width: 12, height: 12)
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
        ButtonLabelWithIconShort(
          user.city,
          icon: "building.2.crop.circle.fill",
          textColor: .accent,
          bgColor: .csDarkGrey
        )
      } else {
        HStack(spacing:10) {
          Text("Check your internet connection")
            .font(.footnote)
            .fontDesign(.monospaced)
            .fontWeight(.medium)
            .foregroundStyle(.orange)
          ProgressView()
        }
      }
    }
  }
}

#Preview {
  HomeHeaderView()
    .environmentObject(AuthViewModel())
}
