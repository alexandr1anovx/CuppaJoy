//
//  MyOrdersScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 03.01.2025.
//

import SwiftUI

struct MyOrdersScreen: View {
  
  @Binding var selectedTab: Tab
  @State private var selectedStatus: OrderStatus = .ongoing
  @EnvironmentObject var orderViewModel: OrderViewModel
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      VStack {
        statusTabs
        if selectedStatus == .ongoing {
          ongoingOrdersList
        } else {
          receivedOrdersList
        }
      }
      .padding(.top)
      .onAppear { selectedStatus = .ongoing }
    }
  }
  
  // MARK: Status Tabs
  private var statusTabs: some View {
    HStack(spacing: 5) {
      ForEach(OrderStatus.allCases) { status in
        Button {
          selectedStatus = status
        } label: {
          ButtonLabelWithIconShort(
            status.title,
            icon: status.iconName,
            textColor: status == selectedStatus ? .orange : .gray,
            bgColor: status == selectedStatus ? .csDarkGrey : .clear
          )
        }
      }
    }
  }
  
  // MARK: Empty Ongoing Orders View
  private var emptyOngoingOrdersView: some View {
    ContentUnavailableView {
      Label("Ongoing Orders", systemImage: "text.badge.xmark")
        .foregroundStyle(.csCream)
    } description: {
      Text("You don't have any ongoing orders.\nTry to refresh if something isn't working.")
    } actions: {
      HStack(spacing: 12) {
        Button {
          selectedTab = .home
        } label: {
          ButtonLabelWithIconShort(
            "Add",
            icon: "plus.circle.fill",
            textColor: .black,
            bgColor: .csCream
          )
        }
        RefreshButton { orderViewModel.getOngoingOrders() }
      }
      .padding(.top,10)
    }
  }
  
  // MARK: Empty Received Orders View
  private var emptyReceivedOrdersView: some View {
    ContentUnavailableView {
      Label("Received Orders", systemImage: "text.badge.xmark")
        .foregroundStyle(.csCream)
    } description: {
      Text("You don't have any received orders.\nTry to refresh if something isn't working.")
    } actions: {
      RefreshButton {
        orderViewModel.getReceivedOrders()
      }
      .padding(.top,10)
    }
  }
  
  // MARK: Ongoing Orders List
  @ViewBuilder
  private var ongoingOrdersList: some View {
    if orderViewModel.ongoingOrders.isEmpty {
      emptyOngoingOrdersView
    } else {
      List(orderViewModel.ongoingOrders) { order in
        OngoingOrderCell(for: order)
          .listRowBackground(Color.csBlack)
      }
      .customListStyle(rowSpacing: 15, shadowRadius: 5)
    }
  }
  
  // MARK: Received Orders List
  @ViewBuilder
  private var receivedOrdersList: some View {
    if orderViewModel.receivedOrders.isEmpty {
      emptyReceivedOrdersView
    } else {
      List(orderViewModel.receivedOrders) { order in
        ReceivedOrderCell(for: order)
          .listRowBackground(Color.csBlack)
      }
      .customListStyle(rowSpacing: 15, shadowRadius: 5)
    }
  }
}

#Preview {
  MyOrdersScreen(selectedTab: .constant(.myOrders))
    .environmentObject(OrderViewModel())
}
