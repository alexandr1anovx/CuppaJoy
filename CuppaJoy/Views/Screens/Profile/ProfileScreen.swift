//
//  ProfileScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.10.2024.
//

import SwiftUI

struct ProfileScreen: View {
  var body: some View {
    ZStack {
      Color.mainGradientBackground.ignoresSafeArea()
      
      VStack(spacing: 25) {
        ProfileScreenCell(
          image: .man,
          header: "Name",
          content: "Alexander"
        )
        ProfileScreenCell(
          image: .mobile,
          header: "Phone number",
          content: "+380955302040"
        )
        ProfileScreenCell(
          image: .envelope,
          header: "Email",
          content: "myEmail@gmail.com"
        )
        ProfileScreenCell(
          image: .map,
          header: "Selected coffee shop address",
          content: "3-rd Slobidska"
        )
        Spacer()
      }
      .padding(20)
    }
    .navigationTitle("Profile")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        ReturnButton()
      }
    }
  }
}

#Preview {
  ProfileScreen()
}
