//
//  MyOrdersScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 03.01.2025.
//

import SwiftUI

enum OrderStatus: String, CaseIterable {
  case onGoing, received
  
  var title: String {
    switch self {
    case .onGoing: "On going"
    case .received: "Received"
    }
  }
}

struct OrderTabScreen: View {
  @State private var selectedTab = OrderStatus.onGoing
  
  var body: some View {
    ZStack {
      Color.mainGradientBackground.ignoresSafeArea()
      
      VStack {
        orderStatusTabs
        if selectedTab == .onGoing {
          onGoingOrders
        } else {
          receivedOrders
        }
      }.padding(.top)
    }
  }
  
  private var orderStatusTabs: some View {
    HStack(spacing: 10) {
      ForEach(OrderStatus.allCases, id: \.self) { tab in
        IndicatedTabItem(
          tab: tab.title,
          isSelected: tab == selectedTab
        )
        .onTapGesture {
          withAnimation(.linear) { selectedTab = tab }
        }
      }
    }
  }
  
  private var onGoingOrders: some View {
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
