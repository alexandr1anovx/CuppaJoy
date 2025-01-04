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
        HStack(spacing: 50) {
          ForEach(OrderTab.allCases, id: \.self) { tab in
            UnderlinedTabItem(
              tabName: tab.rawValue,
              isSelected: tab == selectedTab
            )
            .onTapGesture {
              withAnimation { selectedTab = tab }
            }
          }
        }
        .padding(.top)
        
        if selectedTab == .onGoing {
          OrderOngoingView()
        } else {
          OrderHistoryView()
        }
      }
    }
  }
}

#Preview {
  OrderTabScreen()
}


struct UnderlinedTabItem: View {
  let tabName: String
  let isSelected: Bool
  
  var body: some View {
    VStack {
      Text(tabName)
        .font(.poppins(.medium, size: 16))
        .foregroundColor(isSelected ? .cstCream : .cstGray)
      Rectangle()
        .frame(width: 80, height: 2)
        .foregroundColor(isSelected ? .cstCream : .clear)
        .animation(.easeInOut, value: isSelected)
    }
  }
}

