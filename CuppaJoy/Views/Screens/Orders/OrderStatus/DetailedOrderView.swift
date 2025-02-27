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
          if order.milk != "" {
            row("Milk:", content: order.milk)
          }
          if order.flavor != "" {
            row("Flavor:", content: order.flavor)
          }
          
          row("Variety:", content: order.variety)
          
          if order.sugarSticks > 0 {
            row("Sugar sticks:", content: "\(order.sugarSticks)")
          }
          if order.iceCubes > 0 {
            row("Ice cubes:", content: "\(order.iceCubes)")
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
