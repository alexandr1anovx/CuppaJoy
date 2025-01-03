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
  let tab: TabItem
  @Binding var selectedTab: TabItem
  
  var body: some View {
    Button {
      withAnimation(.smooth) {
        selectedTab = tab
      }
    } label: {
      HStack(spacing: 10) {
        Image(image)
          .resizable()
          .scaledToFit()
          .frame(maxWidth: 25)
          .foregroundStyle(.cstCream)
        
        if selectedTab == tab {
          Text(title)
            .font(.poppins(.medium, size: 16))
            .foregroundStyle(.cstCream)
        }
      }
      .padding(.vertical, 13)
      .padding(.horizontal)
    }
  }
}

#Preview {
  TabBarButton(
    title: "",
    image: "house",
    tab: .home,
    selectedTab: .constant(.home)
  )
}
