//
//  HomeHeader.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

struct HomeHeaderView: View {
  var body: some View {
    HStack(spacing: 20) {
      
      VStack(alignment: .leading, spacing: 15) {
        Text("Initials")
          .font(.poppins(.medium, size: 18))
          .foregroundStyle(.cstCream)
        Text("+380(67)-936-75-89")
          .font(.poppins(.medium, size: 13))
          .foregroundStyle(.cstWhite)
        
        HStack {
          Image("location")
            .resizable()
            .frame(width: 23, height: 23)
            .foregroundStyle(.cstCream)
          Text("Street address")
            .font(.poppins(.medium, size: 14))
            .foregroundStyle(.cstWhite)
        }
      }
      
      Spacer()
      
      NavigationLink {
        CompletedOrderScreen()
      } label: {
        Image("bag")
          .resizable()
          .frame(width: 28, height: 28)
          .foregroundStyle(.cstCream)
      }
      
      NavigationLink {
        ProfileScreen()
      } label: {
        Image("user")
          .resizable()
          .frame(width: 27, height: 27)
          .foregroundStyle(.cstCream)
      }
    }
    .padding(.horizontal, 25)
    .padding(.top, 10)
  }
}
