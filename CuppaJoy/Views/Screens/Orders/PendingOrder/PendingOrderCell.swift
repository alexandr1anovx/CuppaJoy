//
//  ConfirmedOrderCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 29.12.2024.
//

import SwiftUI

struct PendingOrderCell: View {
  
  var body: some View {
    HStack(spacing: 20) {
      Image(systemName: "cup.and.saucer.fill")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 35, height: 35)
        .foregroundStyle(.cstCream)
      
      VStack(alignment: .leading, spacing: 5) {
        Text("Americano")
          .font(.poppins(.medium, size: 15))
          .foregroundStyle(.cstCream)
        Text("Single, Iced, Medium")
          .font(.poppins(.regular, size: 12))
          .foregroundStyle(.cstGray)
        Text("x 2")
          .font(.poppins(.bold, size: 13))
          .foregroundStyle(.cstGray)
      }
      
      Spacer()
      
      Text("₴ 35.00")
      .font(.poppins(.bold, size: 16))
      .foregroundStyle(.cstCream)
    }
    .listRowBackground(Color.cstBlack)
  }
}

#Preview {
  PendingOrderCell()
}
