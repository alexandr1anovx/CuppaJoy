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
        .font(.poppins(.bold, size: 19))
        .foregroundStyle(.white)
      Text(subtitle)
        .font(.poppins(.regular, size: 15))
        .foregroundStyle(.gray)
    }
  }
}

#Preview {
  AuthHeaderView(
    title: "Title.",
    subtitle: "Subtitle with some text."
  )
}
