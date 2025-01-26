//
//  MyOrdersScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 03.01.2025.
//

import SwiftUI

enum OrderTabStatus: String, CaseIterable {
  case ongoing, received
  
  var title: String {
    switch self {
    case .ongoing: "Ongoing"
    case .received: "Received"
    }
  }
}

struct OrderTabScreen: View {
  @State private var selectedTabStatus = OrderTabStatus.ongoing
  
  var body: some View {
    ZStack {
      Color.mainGradientBackground.ignoresSafeArea()
      
      VStack {
        orderStatusTabs
        if selectedTabStatus == .ongoing {
          ongoingOrders
        } else {
          receivedOrders
        }
      }
      .padding(.top)
    }
  }
  
  private func indicatedTab(title: String, isSelected: Bool) -> some View {
    Text(title)
      .font(.subheadline)
      .fontWeight(.medium)
      .fontDesign(.rounded)
      .foregroundStyle(isSelected ? .csYellow : .gray)
      .padding(10)
      .background(isSelected ? .black : .clear)
      .clipShape(.capsule)
  }
  
  private var orderStatusTabs: some View {
    HStack(spacing: 10) {
      ForEach(OrderTabStatus.allCases, id: \.self) { tabStatus in
        indicatedTab(
          title: tabStatus.title,
          isSelected: tabStatus == selectedTabStatus
        )
        .onTapGesture {
          withAnimation(.easeInOut(duration: 0.7)) {
            selectedTabStatus = tabStatus
          }
        }
      }
    }
  }
  
  private var ongoingOrders: some View {
    List {
      OrderReceiptCell(
        coffee: .americano,
        address: "3rd Slobidska",
        price: 35.00
      )
    }
    .shadow(radius: 10)
    .listStyle(.insetGrouped)
    .listRowSpacing(20)
    .scrollIndicators(.hidden)
    .scrollContentBackground(.hidden)
  }
  
  private var receivedOrders: some View {
    List {
      OrderReceiptCell(
        coffee: Coffee.cappuccino,
        address: "3rd Slobidska",
        price: 39.50
      )
    }
    .shadow(radius: 10)
    .listStyle(.insetGrouped)
    .listRowSpacing(20)
    .scrollContentBackground(.hidden)
  }
}

#Preview {
  OrderTabScreen()
}
