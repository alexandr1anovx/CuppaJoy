//
//  ReceivedOrderCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 23.02.2025.
//

import SwiftUI

struct ReceivedOrderCell: View {
  
  let order: Order
  @State private var isShownConfigurationSheet = false
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      // Header
      HStack(spacing: 0) {
        dateLabel
        Spacer()
        priceAndPointsLabel
      }
      row("Coffee:", content: order.coffee)
      row("Size:", content: order.cupSize)
      // Footer
      HStack {
        Spacer()
        configurationsButton
      }
    }
    .sheet(isPresented: $isShownConfigurationSheet) {
      DetailedOrderView(order: order)
        .presentationDetents([.large])
        .presentationCornerRadius(30)
    }
  }
  
  private var dateLabel: some View {
    Text(order.stringDate)
      .font(.footnote)
      .fontWeight(.semibold)
      .fontDesign(.monospaced)
      .foregroundStyle(.gray)
  }
  
  private var priceAndPointsLabel: some View {
    HStack(spacing: 2) {
      HStack(spacing: 6) {
        Image(.star)
          .resizable()
          .frame(width: 15, height: 15)
        Text(order.stringPoints)
      }
      .font(.caption)
      .foregroundStyle(.orange)
      .padding(8)
      .background(.csDarkGrey)
      .clipShape(.capsule)
      Text(order.stringPrice)
        .font(.subheadline)
        .foregroundStyle(.csCream)
        .padding(8)
        .background(.csDarkGrey)
        .clipShape(.capsule)
    }
    .fontWeight(.bold)
  }
  
  private func row(_ title: String, content: String) -> some View {
    HStack(spacing: 5) {
      Text(title).foregroundStyle(.white)
      Text(content).foregroundStyle(.csCream)
    }
    .font(.footnote)
    .fontWeight(.semibold)
  }
  
  private var configurationsButton: some View {
    Button {
      isShownConfigurationSheet.toggle()
    } label: {
      Text("Configurations")
        .font(.caption)
        .fontWeight(.bold)
        .foregroundStyle(.white)
        .padding(10)
        .background(.csDarkGrey)
        .clipShape(.capsule)
    }.buttonStyle(.plain)
  }
}

#Preview {
  ReceivedOrderCell(order: MockData.order)
}
