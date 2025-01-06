//
//  UnderlinedTabItem.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.01.2025.
//

import SwiftUI

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
