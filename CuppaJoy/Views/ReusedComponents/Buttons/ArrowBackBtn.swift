//
//  DismissXButton.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 09.10.2024.
//

import SwiftUI

struct ArrowBackBtn: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Button {
      dismiss()
    } label: {
      Image(systemName: "arrow.left.circle")
        .font(.title3)
        .foregroundStyle(.cstCream)
        .opacity(0.7)
    }
  }
}

#Preview {
  ArrowBackBtn()
}
