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
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      VStack(spacing: 30) {
        ProfileDataCell(
          image: "user",
          header: "Name",
          content: "Alexander"
        )
        ProfileDataCell(
          image: "smartphone",
          header: "Phone number",
          content: "+380955302040"
        )
        ProfileDataCell(
          image: "mailbox",
          header: "Email",
          content: "myEmail@gmail.com"
        )
        ProfileDataCell(
          image: "map",
          header: "Favourite location",
          content: "3-rd Slobidska"
        )
        Spacer()
      }
      .padding(.top, 25)
    }
    .navigationTitle("Profile")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        ArrowBackBtn()
      }
    }
  }
}

#Preview {
  ProfileScreen()
}
