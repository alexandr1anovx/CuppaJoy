//
//  TabBar.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct CustomTabBar: View {
    @State private var selectedTab = Tab.home
    @State private var isShownTabBar: Bool = true
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeScreen(isShownTabBar: $isShownTabBar)
                    .tag(Tab.home)
                RewardsScreen(isShownTabBar: $isShownTabBar)
                    .tag(Tab.rewards)
                OrdersScreen(isShownTabBar: $isShownTabBar)
                    .tag(Tab.orders)
            }
            
            if isShownTabBar {
                HStack {
                    ForEach(Tab.allCases, id: \.self) { tab in
                        BarButton(
                            title: tab.title,
                            image: tab.iconName,
                            tab: tab,
                            selectedTab: $selectedTab
                        )
                        if tab != Tab.allCases.last {
                            Spacer()
                        }
                    }
                }
                .padding(.vertical, 11)
                .padding(.horizontal)
                .background(.primarySystem)
                .clipShape(.capsule)
                .padding(.horizontal, 25)
                .shadow(radius: 8)
            }
        }
    }
}

#Preview {
    CustomTabBar()
}
