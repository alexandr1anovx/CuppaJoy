//
//  OngoingOrderCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 23.02.2025.
//

import SwiftUI

struct OngoingOrderCell: View {
  
  let order: Order
  @State private var isShownDetailedOrderView = false
  @EnvironmentObject var orderViewModel: OrderViewModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      header
      row("Type:", content: order.coffee.title, icon: .coffeeBeans)
      row("Size:", content: order.cupSize.title, icon: .coffee)
      HStack {
        orderDetailsButton
        Spacer()
        cancelOrderButton
      }
      .padding(.top, 5)
    }
  }
  
  private var header: some View {
    HStack {
      Text(order.formattedDate)
        .font(.caption)
        .fontWeight(.medium)
        .fontDesign(.monospaced)
        .foregroundStyle(.gray)
      Spacer()
      Text("₴\(order.totalPrice, specifier: "%.2f")")
        .font(.headline)
        .fontWeight(.bold)
        .padding(9)
        .background(.csDarkGrey)
        .clipShape(.capsule)
        .shadow(radius: 5)
    }
  }
  
  private func row(
    _ title: String,
    content: String,
    icon: ImageResource
  ) -> some View {
    HStack(spacing: 6) {
      Image(icon).foregroundStyle(.accent)
      Text(title).foregroundStyle(.accent)
      Text(content)
    }
    .font(.footnote)
    .fontWeight(.bold)
  }
  
  private var orderDetailsButton: some View {
    Button {
      isShownDetailedOrderView.toggle()
    } label: {
      HStack(spacing: 5) {
        Image(systemName: "info.circle")
        Text("Order details")
      }
      .font(.caption)
      .fontWeight(.bold)
      .foregroundStyle(.white)
      .padding(10)
      .background(.csDarkGrey)
      .clipShape(.capsule)
    }
    .buttonStyle(.plain)
    .sheet(isPresented: $isShownDetailedOrderView) {
      DetailedOrderView(order: order)
        .presentationDetents([.height(250)])
        .presentationDragIndicator(.hidden)
        .presentationCornerRadius(30)
        .presentationCompactAdaptation(.sheet)
    }
  }
  
  private var cancelOrderButton: some View {
    Button {
      withAnimation {
        orderViewModel.cancelOrder(order)
      }
    } label: {
      HStack(spacing: 5) {
        Image(systemName: "xmark.circle")
        Text("Cancel order")
      }
      .font(.caption)
      .fontWeight(.bold)
      .foregroundStyle(.white)
      .padding(10)
      .background(.csRed)
      .clipShape(.capsule)
    }
    .buttonStyle(.plain)
  }
}

#Preview {
  OngoingOrderCell(order: MockData.order)
}
