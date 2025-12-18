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
  
  var orderDetails: [(String, String)] {
    [
      ("Coffee", order.coffee),
      ("Size", order.cupSize),
      ("Count", "\(order.cupCount)"),
      ("Sugar sticks", "\(order.sugarSticks)"),
      ("Ice cubes", "\(order.iceCubes)"),
      ("Variety", order.variety),
      ("Milk", order.milk),
      ("Flavor", order.flavor)
    ]
  }
  
  var body: some View {
    ZStack{
      Color.csBlack.ignoresSafeArea(.all)
      VStack(spacing: 0) {
        Label("Configurations", systemImage: "list.bullet")
          .font(.headline)
          .fontWeight(.semibold)
          .foregroundStyle(.orange)
        
        List(Array(orderDetails.enumerated()), id: \.offset) { index, item in
          row(title: item.0, content: item.1)
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(10)
        .environment(\.defaultMinListRowHeight, 45)
        .scrollContentBackground(.hidden)
        .shadow(radius: 5)
        Button {
          dismiss()
        } label: {
          ButtonLabel("Close", textColor: .red, bgColor: .black)
        }
      }.padding(.top)
    }
  }
  
  private func row(title: String, content: String) -> some View {
    HStack {
      Text("\(title):")
        .font(.subheadline)
        .fontWeight(.semibold)
        .foregroundStyle(.white)
        .opacity(UIConstants.Opacity.overlay)
      Text(content)
        .font(.callout)
        .fontWeight(.bold)
        .foregroundStyle(.csCream)
    }
  }
}

#Preview {
  DetailedOrderView(order: MockData.order)
}
