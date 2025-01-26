//
//  ConfirmedOrderCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 29.12.2024.
//

import SwiftUI

struct PendingOrderCell: View {
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Text("Coffee Title")
          .font(.callout).bold()
        Spacer()
        Text("₴ Price")
          .font(.system(size: 18)).bold()
          .foregroundStyle(.csYellow)
      }
      Text("Coffee Additives")
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
      Text("Coffee Cup Count")
        .font(.footnote).bold()
        .foregroundStyle(.gray)
    }
    .listRowBackground(Color.black)
  }
}

#Preview {
  PendingOrderCell()
}
