//
//  MyOrdersScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 03.01.2025.
//

import SwiftUI

enum OrderStatus: String, CaseIterable {
  case onGoing = "On going"
  case history = "History"
}

struct MyOrdersScreen: View {
  
  @State private var selectedTab: OrderStatus = .onGoing
  
  @State private var isSelectedOngoing: Bool = true
  @State private var isSelectedHistory: Bool = true
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.mainBackgroundGradient.ignoresSafeArea()
        
        VStack {
          
          HStack(spacing: 50) {
            ForEach(OrderStatus.allCases, id: \.self) { tab in
              OrderTab(
                tabName: tab.rawValue,
                isSelected: tab == selectedTab
              )
              .onTapGesture {
                withAnimation {
                  selectedTab = tab
                }
              }
            }
          }
          
          if selectedTab == .onGoing {
            OngoingOrderScreen(isTabBarVisible: .constant(false))
          } else {
            GreetingScreen()
          }
        }
        .padding(.top)
      }
    }
  }
}

#Preview {
  MyOrdersScreen()
}


struct OrderTab: View {
  let tabName: String
  let isSelected: Bool
  
  var body: some View {
    
    VStack {
      Text(tabName)
        .font(.poppins(.medium, size: 16))
        .foregroundColor(isSelected ? .cstLightPink : .cstGray)
      Rectangle()
        .frame(width: 80, height: 2)
        .foregroundColor(isSelected ? .cstLightPink : .clear)
        .animation(.easeInOut, value: isSelected)
    }
  }
}
