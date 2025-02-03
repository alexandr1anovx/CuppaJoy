//
//  UnderlinedTabItem.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.01.2025.
//

import SwiftUI

struct IndicatedTabItem: View {
  
  let tab: String
  let isSelected: Bool
  
  var body: some View {
    
    Text(tab)
      .font(.poppins(.medium, size: 13))
      .foregroundStyle(isSelected ? .csYellow : .gray)
      .padding(10)
      .background(
        isSelected ?
        Color.csBrown.opacity(0.8) : Color.clear
      )
      .clipShape(.capsule)
  }
}

#Preview {
  IndicatedTabItem(tab: "History", isSelected: true)
}
