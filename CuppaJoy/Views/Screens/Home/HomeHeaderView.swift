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
        .font(.headline)
        .fontDesign(.monospaced)
        .foregroundStyle(.white)
        .lineLimit(2)
      HStack(spacing: 5) {
        Text("Bonuses:")
          .font(.callout)
          .fontDesign(.monospaced)
          .fontWeight(.medium)
          .foregroundStyle(.gray)
        Text("₴₴")
          .font(.callout).bold()
          .foregroundStyle(.csCream)
      }
    }
  }
  
  private var mapButton: some View {
    NavigationLink {
      // ...
    } label: {
      Image(.map).foregroundStyle(.csCream)
    }
  }
  
  private var profileButton: some View {
    NavigationLink {
      ProfileScreen()
    } label: {
      Image(.man).foregroundStyle(.csCream)
    }
  }
}

#Preview {
  HomeHeaderView()
}
