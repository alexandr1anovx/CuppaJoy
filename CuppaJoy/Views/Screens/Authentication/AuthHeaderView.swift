//
//  AuthHeaderView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 10.01.2025.
//

import SwiftUI

struct AuthHeaderView: View {
  let title: String
  let subtitle: String
  
  var body: some View {
    HStack(alignment: .firstTextBaseline, spacing: 8) {
      Text(title)
        .font(.headline)
        .fontDesign(.monospaced)
        .foregroundStyle(.white)
      Text(subtitle)
        .font(.subheadline)
        .fontDesign(.monospaced)
        .foregroundStyle(.gray)
    }
    .shadow(radius: 8)
  }
}

#Preview {
  AuthHeaderView(
    title: "Title.",
    subtitle: "Subtitle with some text."
  )
}
