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
    Image(.arrowLeft)
      .foregroundStyle(.accent)
      .opacity(0.8)
      .onTapGesture {
        dismiss()
      }
  }
}

#Preview {
  ReturnButton()
}
