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
    }.padding(.bottom, 5)
  }
  
  private func orderHeader(date: String, price: Double) -> some View {
    HStack(spacing: 10) {
      Text(date)
        .font(.footnote)
        .foregroundStyle(.gray)
        .lineLimit(1)
      Spacer()
      Text("₴ \(price, specifier: "%.2f")")
        .font(.title3).bold()
        .foregroundStyle(.csCream)
    }
  }
  
  private func orderRow(image: ImageResource, content: String) -> some View {
    HStack(spacing: 15) {
      Image(image)
        .resizable()
        .frame(width: 17, height: 17)
        .foregroundStyle(.accent)
      Text(content)
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.white)
        .multilineTextAlignment(.leading)
        .lineLimit(2)
    }
  }
  
  private var orderDetails: some View {
    HStack(spacing:5) {
      Spacer()
      Image(systemName: "info.circle")
      Text("Order Details")
    }
    .font(.footnote)
    .foregroundStyle(.gray)
  }
}

#Preview {
  OrderReceiptCell(
    coffee: .americano,
    address: "Soborna Street, 50A",
    price: 35.00
  )
}
