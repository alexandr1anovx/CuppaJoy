//
//  HomeHeader.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

struct HomeHeaderView: View {
  
  var body: some View {
    HStack(spacing: 23) {
      userDataView
      Spacer()
      mapButton
      profileButton
    }
    .padding(25)
  }
  
  // MARK: - User Data
  private var userDataView: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("Alexander Andrianov")
        .font(.callout)
        .fontWeight(.bold)
        .fontDesign(.rounded)
        .foregroundStyle(.csCreamy)
        .lineLimit(2)
      HStack(spacing: 3) {
        Text("bonuses:")
          .font(.callout)
          .fontWeight(.medium)
          .fontDesign(.rounded)
          .foregroundStyle(.gray)
        Text("50 UAH")
          .font(.subheadline)
          .fontWeight(.bold)
          .fontDesign(.rounded)
          .foregroundStyle(.csYellow)
      }
    }
  }
  
  // MARK: - QR Code
  private var mapButton: some View {
    NavigationLink {
      //
    } label: {
      Image(.map).foregroundStyle(.csCreamy)
    }
  }
  
  // MARK: - Profile Button
  private var profileButton: some View {
    NavigationLink {
      ProfileScreen()
    } label: {
      // add the ability to change gender in the future.
      Image(.man).foregroundStyle(.csCreamy)
    }
  }
}

#Preview {
  HomeHeaderView()
}
