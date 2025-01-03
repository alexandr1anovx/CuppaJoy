//
//  PaymentMethodCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

struct PaymentMethodCell: View {
  var body: some View {
    HStack(spacing: 20) {
      VStack(alignment: .leading, spacing: 10) {
        Text("Credit Card")
          .font(.poppins(.medium, size: 17))
          .foregroundStyle(.cstWhite)
        Text("2540 xxxx xxxx 2648")
          .font(.poppins(.medium, size: 14))
          .foregroundStyle(.cstGray)
      }
      
      Spacer()
      
      Image("visa")
        .resizable()
        .scaledToFit()
        .frame(width: 40, height: 40)
    }
  }
}

#Preview {
  PaymentMethodCell()
}
