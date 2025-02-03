//
//  HomeHeader.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

struct HomeHeaderView: View {
  
  var body: some View {
    HStack(spacing: 25) {
      userDataView
      Spacer()
      mapButton
      profileButton
    }
    .padding(25)
  }
  
  private var userDataView: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("Alexander Andrianov")
        .font(.poppins(.bold, size: 16))
        .foregroundStyle(.white)
        .lineLimit(2)
      HStack {
        Text("Bonuses:")
          .font(.poppins(.medium, size: 14))
          .foregroundStyle(.gray)
        Text("50 UAH")
          .font(.poppins(.bold, size: 15))
          .foregroundStyle(.accent)
      }
    }
  }
  
  private var mapButton: some View {
    NavigationLink {
      // ...
    } label: {
      Image(.map).foregroundStyle(.accent)
    }
  }
  
  private var profileButton: some View {
    NavigationLink {
      ProfileScreen()
    } label: {
      Image(.man).foregroundStyle(.accent)
    }
  }
}

#Preview {
  HomeHeaderView()
}
