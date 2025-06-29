//
//  DismissButton.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.01.2025.
//

import SwiftUI

struct DismissButton: View {
  let color: Color
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Button {
      dismiss()
    } label: {
      Image(systemName: "xmark.circle.fill")
        .font(.title)
        .foregroundStyle(color)
        .symbolRenderingMode(.hierarchical)
    }
  }
}

#Preview {
  DismissButton(color: .red)
}
