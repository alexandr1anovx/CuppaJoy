//
//  BackButton.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.04.2025.
//

import SwiftUI

struct BackButton: View {
  var body: some View {
    Image(systemName: "arrowshape.left.circle.fill")
      .font(.callout)
      .foregroundStyle(.accent)
  }
}

#Preview {
  BackButton()
}
