//
//  TotalPriceTemplateView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

struct TotalPriceView: View {
  var body: some View {
    HStack {
      VStack(alignment: .leading, spacing: 8) {
        Text("Total Price")
          .font(.poppins(.medium, size: 15))
          .foregroundStyle(.cstGray)
        Text("UAH 35.00")
          .font(.poppins(.bold, size: 18))
          .foregroundStyle(.cstWhite)
      }
      
      Spacer()
      
      Button {
        // action
      } label: {
        Label("Pay Now", systemImage: "creditcard.fill")
          .font(.poppins(.medium, size: 14))
          .foregroundStyle(.cstDarkBrown)
          .padding(5)
      }
      .tint(.accent)
      .buttonStyle(.borderedProminent)
    }
  }
}

#Preview {
  TotalPriceView()
}
