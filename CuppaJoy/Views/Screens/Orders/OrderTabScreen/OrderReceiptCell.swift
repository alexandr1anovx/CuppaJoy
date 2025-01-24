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
    "24 June, 12:30, by 18:10"
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 15) {
      orderHeader(date: date, price: price)
      orderRow(image: .coffee, content: coffee.title)
      HStack {
        orderRow(image: .map, content: address)
        orderDetails
      }
    }
    .listRowBackground(Color.black)
    .padding(.bottom, 5)
  }
  
  private func orderHeader(date: String, price: Double) -> some View {
    HStack {
      Text(date)
        .font(.poppins(.medium, size: 12))
        .foregroundStyle(.gray)
      Spacer()
      Text("₴ \(String(format: "%.2f", price))")
        .font(.poppins(.bold, size: 17))
        .foregroundStyle(.csYellow)
    }
  }
  
  private func orderRow(image: ImageResource, content: String) -> some View {
    HStack(spacing: 10) {
      Image(image)
        .resizable()
        .frame(width: 18, height: 18)
      Text(content)
        .font(.poppins(.medium, size: 13))
        .multilineTextAlignment(.leading)
        .lineLimit(2)
    }
    .foregroundStyle(.csCreamy)
  }
  
  private var orderDetails: some View {
    HStack(spacing: 5) {
      Spacer()
      Image(systemName: "info.circle")
        .font(.footnote)
      Text("Order Details")
        .font(.poppins(.medium, size: 12))
    }
    .foregroundStyle(.gray)
  }
}

#Preview {
  OrderReceiptCell(
    coffee: Coffee.americano,
    address: "Soborna Street, 50A",
    price: 35.00
  )
}
