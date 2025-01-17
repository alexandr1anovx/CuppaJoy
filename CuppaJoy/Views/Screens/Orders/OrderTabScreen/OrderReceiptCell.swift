//
//  OrderCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct OrderReceiptCell: View {
  
  let coffee: Coffee
  let address: String
  let price: Double
  
  var date: String {
    return "24 June, 12:30, by 18:10"
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      HStack {
        Text(date)
          .font(.poppins(.medium, size: 12))
          .foregroundStyle(.gray)
        Spacer()
        Text("₴ \(String(format: "%.2f", price))")
          .font(.poppins(.bold, size: 16))
          .foregroundStyle(.white)
      }
      
      Label(coffee.rawValue, image: .coffee)
        .font(.poppins(.medium, size: 13))
        .foregroundStyle(.accent)
      
      Label(address, image: .map)
        .font(.poppins(.medium, size: 13))
        .foregroundStyle(.accent)
    }
    .padding(.bottom, 5)
  }
}

#Preview {
  OrderReceiptCell(
    coffee: Coffee.americano,
    address: "Bradford St.1",
    price: 35.00
  )
}
