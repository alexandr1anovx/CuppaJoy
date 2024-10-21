//
//  TabBarButton.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct BarButton: View {
    let title: String
    let image: String
    let tab: Tab
    @Binding var selectedTab: Tab
    
    var body: some View {
        Button {
            withAnimation(.spring) {
                selectedTab = tab
            }
        } label: {
            HStack(spacing: 10) {
                Image(image)
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.primaryReversed)
                    .opacity(0.8)
                
                if selectedTab == tab {
                    Text(title)
                        .font(.poppins(.medium, size: 16))
                        .foregroundStyle(.primaryReversed)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(.primaryReversed.opacity(selectedTab == tab ? 0.08 : 0.0))
            .clipShape(.capsule)
        }
    }
}

/*
#Preview {
    TabBarButton()
}
*/
