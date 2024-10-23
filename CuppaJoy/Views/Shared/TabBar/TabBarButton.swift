//
//  TabBarButton.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct TabBarButton: View {
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
                    .frame(width: 25, height: 25)
                    .foregroundStyle(.primaryGreen)
                    .opacity(0.8)
                
                if selectedTab == tab {
                    Text(title)
                        .font(.poppins(.medium, size: 16))
                        .foregroundStyle(.primaryGreen)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(.primaryGreen.opacity(selectedTab == tab ? 0.2 : 0.0))
            .clipShape(.capsule)
        }
    }
}

#Preview {
    TabBarButton(title: "Home", image: "house", tab: .home, selectedTab: .constant(.home))
}
