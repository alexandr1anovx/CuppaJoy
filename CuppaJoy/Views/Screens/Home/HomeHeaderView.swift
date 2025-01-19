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
            .foregroundStyle(.csYellow)
        }
      }
      .padding()
      .background(Color.csDarkBrown)
      .clipShape(.buttonBorder)
      .shadow(radius: 10)

      Spacer()
      
      NavigationLink {
        QRCodeView()
      } label: {
        Image(.qrcode).foregroundStyle(.csYellow)
      }
      
      NavigationLink {
        ProfileScreen()
      } label: {
        // add the ability to change gender in the future.
        Image(.man).foregroundStyle(.csYellow)
      }
    }
    .padding(25)
  }
}

#Preview {
  HomeHeaderView()
}
