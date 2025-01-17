//
//  MyOrdersScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 03.01.2025.
//

import SwiftUI

enum OrderTab: String, CaseIterable {
  case onGoing = "On going"
  case history = "History"
}

struct OrderTabScreen: View {
  @State private var selectedTab: OrderTab = .onGoing
  
  var body: some View {
    ZStack {
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      VStack {
        HStack(spacing: 10) {
          ForEach(OrderTab.allCases, id: \.self) { tab in
            IndicatedTabItem(
              tab: tab.rawValue,
              isSelected: tab == selectedTab
            )
            .onTapGesture {
              withAnimation(.linear(duration: 0.5)) {
                selectedTab = tab
              }
            }
          }
        }
        if selectedTab == .onGoing {
          OrderOngoingView()
        } else {
          OrderHistoryView()
        }
      }
      .padding(.top)
    }
  }
}

#Preview {
  OrderTabScreen()
}
