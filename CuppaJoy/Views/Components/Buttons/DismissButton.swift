//
//  DismissButton.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.01.2025.
//

import SwiftUI

struct DismissButton: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    Image(systemName: "xmark.circle.fill")
      .imageScale(.large)
      .foregroundStyle(.gray)
      .symbolRenderingMode(.monochrome)
      .onTapGesture {
        dismiss()
      }
  }
}

#Preview {
  DismissButton()
}
