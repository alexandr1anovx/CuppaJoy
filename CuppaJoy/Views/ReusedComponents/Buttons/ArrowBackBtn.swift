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
      Image("arrowLeft")
        .resizable()
        .frame(width: 28, height: 28)
        .foregroundStyle(.cstCream)
        .opacity(0.8)
    }
  }
}

#Preview {
  ArrowBackBtn()
}
