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
      VStack(alignment: .leading, spacing: 15) {
        Text("Initials")
          .font(.poppins(.medium, size: 18))
          .foregroundStyle(.cstWhite)
        Text("Phone number")
          .font(.poppins(.medium, size: 13))
          .foregroundStyle(.cstWhite)
        Label("Address", systemImage: "mappin.and.ellipse")
          .font(.poppins(.medium, size: 14))
          .foregroundStyle(.cstWhite)
      }
      
      Spacer()
      
      NavigationLink {
        QRCodeView()
      } label: {
        Image(systemName: "qrcode")
          .resizable()
          .frame(width: 23, height: 23)
          .foregroundStyle(.cstCream)
      }
      
      NavigationLink {
        ProfileScreen()
      } label: {
        Image("user")
          .resizable()
          .frame(width: 26, height: 26)
          .foregroundStyle(.cstCream)
      }
    }
    .padding(.horizontal, 25)
    .padding(.top, 10)
  }
}

#Preview {
  HomeHeaderView()
}
