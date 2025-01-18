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
      VStack(alignment: .leading, spacing: 8) {
        Text("Alexander Andrianov")
          .font(.poppins(.bold, size: 15))
          .foregroundStyle(.white)
          .lineLimit(2)
        HStack(spacing: 3) {
          Text("Balance:")
            .font(.poppins(.medium, size: 14))
            .foregroundStyle(.gray)
          Text("50 UAH")
            .font(.poppins(.bold, size: 15))
            .foregroundStyle(.accent)
        }
      }
      .padding()
      .background(Color.csBlack)
      .clipShape(.buttonBorder)
      .shadow(radius: 5)

      Spacer()
      
      NavigationLink {
        QRCodeView()
      } label: {
        Image(.qrcode).foregroundStyle(.accent)
      }
      
      NavigationLink {
        ProfileScreen()
      } label: {
        // add the ability to change gender in the future.
        Image(.man).foregroundStyle(.accent)
      }
    }
    .padding(25)
  }
}

#Preview {
  HomeHeaderView()
}
