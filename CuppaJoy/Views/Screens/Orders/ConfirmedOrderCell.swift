//
//  ConfirmedOrderCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 29.12.2024.
//

import SwiftUI

struct ConfirmedOrderCell: View {
  
  var body: some View {
    HStack(spacing: 20) {
      
      Image(systemName: "cup.and.saucer.fill")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 50, height: 50)
        .foregroundStyle(.cstCream)
      
      VStack(alignment: .leading, spacing: 5) {
        Text("Americano")
          .font(.poppins(.medium, size: 16))
          .foregroundStyle(.cstWhite)
        Text("Single, Iced, Medium")
          .font(.poppins(.regular, size: 12))
          .foregroundStyle(.cstGray)
        Text("x 2")
          .font(.poppins(.bold, size: 14))
          .foregroundStyle(.cstGray)
      }
      
      Spacer()
      
      HStack(spacing: 4) {
        Text("₴")
        Text("35.00")
      }
      .font(.poppins(.bold, size: 18))
      .foregroundStyle(.cstCream)
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 20)
        .fill(Color.cstBlue)
    )
    // Changes the default List row background color
    .listRowBackground(Color.cstDarkBrown)
  }
}

#Preview {
  ConfirmedOrderCell()
}
