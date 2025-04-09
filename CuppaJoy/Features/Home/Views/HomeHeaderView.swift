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
    HStack(spacing: 10) {
      if let user = authViewModel.currentUser {
        Image(systemName: "person.fill")
          .imageScale(.large)
          .foregroundStyle(.white)
          .padding(10)
          .background(.csDarkGrey)
          .clipShape(.circle)
        VStack(alignment: .leading, spacing: 10) {
          Text(user.fullName)
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .lineLimit(2)
          Text(user.emailAddress)
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundStyle(.gray)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
        }
        Spacer()
        pointsLabel(user.stringCoins)
      } else {
        ProgressView()
      }
    }
    .padding(.vertical, 30)
    .padding(.horizontal, 15)
  }
  
  private func pointsLabel(_ points: String) -> some View {
    HStack(spacing: 6) {
      Image(.star)
        .resizable()
        .frame(width: 15, height: 15)
      Text(points)
        .font(.footnote)
        .fontWeight(.bold)
    }
    .foregroundStyle(.orange)
    .padding(10)
    .background(.csDarkGrey)
    .clipShape(.capsule)
  }
}

#Preview {
  HomeHeaderView()
    .environmentObject( AuthViewModel() )
}
