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
  @EnvironmentObject var sessionManager: SessionManager
  @Environment(OrderViewModel.self) var viewModel
  
  init(selectedTab: Binding<Tab>) {
    self._selectedTab = selectedTab
  }
  
  var body: some View {
    ZStack {
      Color.appBackgroundDimmed.ignoresSafeArea()
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
  
  // MARK: - Subviews
  
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
  
  private var emptyOngoingOrdersView: some View {
    ContentUnavailableView {
      Label("Ongoing Orders", systemImage: "text.badge.xmark")
        .foregroundStyle(.csCream)
    } description: {
      Text("You don't have any ongoing orders.")
    } actions: {
      Button {
        selectedTab = .home
      } label: {
        ButtonLabelWithIconShort(
          "Add",
          icon: "plus.circle.fill",
          textColor: .black,
          bgColor: .csCream
        )
      }.padding(.top, 10)
    }
  }
  
  private var emptyReceivedOrdersView: some View {
    ContentUnavailableView {
      Label("Received Orders", systemImage: "text.badge.xmark")
        .foregroundStyle(.csCream)
    } description: {
      Text("You don't have any received orders.")
    }
  }
  
  @ViewBuilder
  private var ongoingOrdersList: some View {
    if viewModel.ongoingOrders.isEmpty {
      emptyOngoingOrdersView
    } else {
      List(viewModel.ongoingOrders) { order in
        OngoingOrderCell(for: order)
          .listRowBackground(Color.csBlack)
      }
      .customListStyle(rowSpacing: 15, shadow: 5)
    }
  }
  
  @ViewBuilder
  private var receivedOrdersList: some View {
    if viewModel.receivedOrders.isEmpty {
      emptyReceivedOrdersView
    } else {
      List(viewModel.receivedOrders) { order in
        ReceivedOrderCell(for: order)
          .listRowBackground(Color.csBlack)
      }
      .customListStyle(rowSpacing: 15, shadow: 5)
    }
  }
}
