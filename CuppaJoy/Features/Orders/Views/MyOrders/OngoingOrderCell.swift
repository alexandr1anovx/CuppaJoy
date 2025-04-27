//
//  OngoingOrderCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 23.02.2025.
//

import SwiftUI

struct OngoingOrderCell: View {

  let order: Order
  @State private var isShownConfigurationSheet = false
  @State private var isShownCancelationAlert = false
  @EnvironmentObject var orderViewModel: OrderViewModel

  init(for order: Order) {
    self.order = order
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing:12) {
      // Header
      HStack{
        dateLabel
        Spacer()
        priceAndPointsLabel
      }
      row("Coffee:", content: order.coffee)
      row("Size:", content: order.cupSize)
      // Footer
      HStack {
        configurationsButton
        Spacer()
        cancelationButton
      }.padding(.top,8)
    }
    .alert("Cancel Order", isPresented: $isShownCancelationAlert) {
      Button("Cancel", role: .cancel) {}
      Button("Confirm", role: .destructive) {
        withAnimation { orderViewModel.cancelOngoingOrder(order) }
      }
    } message: {
      Text("Are you sure you want to cancel this order?")
    }
  }
  
  private var dateLabel: some View {
    VStack {
      Text(order.formattedDate)
        .font(.footnote)
        .fontDesign(.monospaced)
        .foregroundStyle(.gray)
      Divider()
        .frame(width: 160)
    }
  }
  
  private var priceAndPointsLabel: some View {
    HStack(spacing: 2) {
      HStack(spacing: 5) {
        Image(systemName: "star.leadinghalf.filled")
        Text("\(order.points)")
      }
      .foregroundStyle(.orange)
      .padding(8)
      .background(.csDarkGrey)
      Text(order.formattedPrice)
        .foregroundStyle(.csCream)
        .padding(8)
        .background(.csDarkGrey)
    }
    .font(.footnote)
    .fontWeight(.bold)
    .clipShape(.capsule)
  }
  
  private func row(_ title: String, content: String) -> some View {
    HStack(spacing: 5) {
      Text(title).foregroundStyle(.gray)
      Text(content).foregroundStyle(.csCream)
        .fontWeight(.semibold)
    }
    .font(.footnote)
  }
  
  private var configurationsButton: some View {
    Button {
      isShownConfigurationSheet.toggle()
    } label: {
      Text("Configurations")
        .font(.caption)
        .fontWeight(.medium)
        .foregroundStyle(.white)
        .padding(8)
        .background(.csDarkGrey)
        .clipShape(.capsule)
    }
    .buttonStyle(.plain)
    .sheet(isPresented: $isShownConfigurationSheet) {
      DetailedOrderView(order: order)
        .presentationDetents([.large])
        .presentationCornerRadius(30)
    }
  }
  
  private var cancelationButton: some View {
    Button {
      isShownCancelationAlert.toggle()
    } label: {
      Text("Cancel Order")
        .font(.caption)
        .fontWeight(.medium)
        .foregroundStyle(.red)
        .padding(8)
        .background(.csDarkGrey)
        .clipShape(.capsule)
    }.buttonStyle(.plain)
  }
}

#Preview {
  OngoingOrderCell(for: MockData.order)
}
