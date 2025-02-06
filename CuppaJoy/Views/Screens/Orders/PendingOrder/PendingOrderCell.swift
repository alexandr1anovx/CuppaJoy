//
//  ConfirmedOrderCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 29.12.2024.
//

import SwiftUI

struct PendingOrderCell: View {
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack {
        Text("Coffee Title")
          .font(.callout).bold()
          .fontDesign(.monospaced)
        Spacer()
        Text("₴ 35.00")
          .font(.title3).bold()
          .foregroundStyle(.csCream)
      }
      Text("Coffee Additives")
        .font(.footnote)
        .fontWeight(.medium)
        .fontDesign(.monospaced)
        .foregroundStyle(.gray)
      Text("Coffee Cup Count")
        .font(.footnote)
        .fontWeight(.medium)
        .fontDesign(.monospaced)
        .foregroundStyle(.gray)
    }
  }
}

#Preview {
  PendingOrderCell()
}
