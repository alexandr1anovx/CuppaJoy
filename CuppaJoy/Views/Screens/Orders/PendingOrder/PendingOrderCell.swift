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
      Image(.coffee)
        .foregroundStyle(.accent)
      VStack(alignment: .leading, spacing: 5) {
        Text("Americano")
          .font(.poppins(.bold, size: 14))
          .foregroundStyle(.accent)
        Text("Single, Iced, Medium")
          .font(.poppins(.medium, size: 12))
          .foregroundStyle(.gray)
        Text("x 2")
          .font(.poppins(.bold, size: 13))
          .foregroundStyle(.gray)
      }
      Spacer()
      Text("₴ 35.00")
        .font(.poppins(.bold, size: 16))
        .foregroundStyle(.white)
    }
    .listRowBackground(Color.black)
  }
}

#Preview {
  PendingOrderCell()
}
