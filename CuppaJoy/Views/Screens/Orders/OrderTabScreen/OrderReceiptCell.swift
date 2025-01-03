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
    return "24 June, 12:30, by 18:10"
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      HStack {
        Text(date)
          .font(.poppins(.regular, size: 12))
          .foregroundStyle(.cstGray)
        Spacer()
        Text("₴ \(String(format: "%.2f", price))")
          .font(.poppins(.bold, size: 17))
          .foregroundStyle(.cstWhite)
      }
      
      VStack(alignment: .leading, spacing: 15) {
        HStack(spacing: 10) {
          Image(systemName: "mug")
            .frame(width: 20, height: 20)
            .foregroundStyle(.cstCream)
          Text(coffee.rawValue)
            .font(.poppins(.medium, size: 14))
            .foregroundStyle(.cstWhite)
        }
        
        HStack(spacing: 10) {
          Image(systemName: "map")
            .frame(width: 20, height: 20)
            .foregroundStyle(.cstCream)
          Text(address)
            .font(.poppins(.medium, size: 14))
            .foregroundStyle(.cstWhite)
        }
      }
    }
    .padding(.bottom,8)
  }
}

#Preview {
  OrderReceiptCell(
    coffee: Coffee.americano,
    address: "Bradford St.1",
    price: 35.00
  )
}
