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
  
  private var date: String {
    return "24 June | 12:30 | by 18:10"
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      HStack {
        Text(date)
          .font(.poppins(.regular, size: 13))
          .foregroundStyle(.cstGray)
        Spacer()
        Text("₴ \(String(format: "%.2f", price))")
          .font(.poppins(.bold, size: 18))
          .foregroundStyle(.cstWhite)
      }
      
      HStack(spacing: 10) {
        Image("coffeeGlass")
          .resizable()
          .frame(width: 25, height: 25)
          .foregroundStyle(.cstWhite)
        Text(coffee.rawValue)
          .font(.poppins(.medium, size: 14))
          .foregroundStyle(.cstCream)
      }
      
      HStack(spacing: 10) {
        Image("map")
          .resizable()
          .frame(width: 25, height: 25)
          .foregroundStyle(.cstWhite)
        Text(address)
          .font(.poppins(.medium, size: 14))
          .foregroundStyle(.cstCream)
      }
    }
  }
}

#Preview {
  OrderReceiptCell(
    coffee: Coffee.americano,
    address: "Bradford St.1",
    price: 35.00
  )
}
