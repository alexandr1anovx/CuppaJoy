//
//  UserDataCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.10.2024.
//

import SwiftUI

struct ProfileScreenCell: View {
  
  let image: ImageResource
  let header: String
  let content: String
  
  var body: some View {
    HStack(spacing: 12) {
      RoundedRectangle(cornerRadius: 10)
        .fill(Color.brownDarkBrownGradient)
        .frame(width: 35, height: 35)
        .overlay {
          Image(image)
            .resizable()
            .scaledToFit()
            .frame(width: 20, height: 20)
            .foregroundStyle(.white).opacity(0.7)
        }
      
      VStack(alignment: .leading, spacing: 5) {
        Text(header)
          .font(.poppins(.medium, size: 12))
          .foregroundStyle(.gray)
        Text(content)
          .font(.poppins(.medium, size: 14))
          .foregroundStyle(.accent)
      }
      
      Spacer()
      
      Image(.edit)
        .foregroundStyle(.gray)
        .onTapGesture {
          // action
        }
    }
  }
}

#Preview {
  ProfileScreenCell(
    image: .man,
    header: "Name",
    content: "Alexander"
  )
}
