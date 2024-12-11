//
//  CustomTabBar.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

struct CustomTabBar: View {
  private let tabs = TabItem.allCases
  @Binding var selectedTab: TabItem
  
  var body: some View {
    HStack {
      ForEach(tabs, id: \.self) { tab in
        TabBarButton(
          title: tab.title,
          image: tab.iconName,
          tab: tab,
          selectedTab: $selectedTab
        )
        if tab != tabs.last {
          Spacer()
        }
      }
    }
    .padding(8)
    .background(Color.cstBrown)
    .clipShape(.rect(cornerRadius: 20))
    .padding(.horizontal, 50)
  }
}
