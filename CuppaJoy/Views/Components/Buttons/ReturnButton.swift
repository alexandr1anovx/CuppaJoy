//
//  DismissXButton.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 09.10.2024.
//

import SwiftUI

struct ReturnButton: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Image(systemName: "arrowshape.left.circle.fill")
      .font(.headline)
      .foregroundStyle(.accent)
      .onTapGesture {
        dismiss()
      }
  }
}

#Preview {
  ReturnButton()
}
