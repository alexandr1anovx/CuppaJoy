//
//  DetailedOrderView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 23.02.2025.
//

import SwiftUI

struct DetailedOrderView: View {
  
  let order: Order
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack {
      Color.csBlack.ignoresSafeArea(.all)
      VStack(spacing: 20) {
        Spacer()
        Label("Detailed Order Information", systemImage: "list.bullet.rectangle.fill")
          .font(.headline)
          .fontWeight(.bold)
          .foregroundStyle(.accent)
        VStack(alignment: .leading, spacing: 6) {
          if order.milk != .none {
            row("Milk:", content: order.milk.title)
          }
          if order.flavor != .none {
            row("Flavor:", content: order.flavor.title)
          }
          
          row("Variety:", content: order.variety.title)
          
          if order.sugarSticks > 0 {
            row("Sugar sticks:", content: "\(order.sugarSticks)")
          }
          if order.iceCount > 0 {
            row("Ice cubes:", content: "\(order.iceCount)")
          }
        }
        Button {
          dismiss()
        } label: {
          ButtonLabel("Close", textColor: .white, pouring: .black)
        }
      }
    }
  }
  
  private func row(_ title: String, content: String) -> some View {
    HStack(spacing: 5) {
      Text(title)
        .font(.subheadline)
        .fontWeight(.bold)
        .foregroundStyle(.white)
        .opacity(0.8)
      Text(content)
        .font(.callout)
        .fontWeight(.bold)
        .foregroundStyle(.orange)
    }
  }
}

#Preview {
  DetailedOrderView(order: MockData.order)
}
