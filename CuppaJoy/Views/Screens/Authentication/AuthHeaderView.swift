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
    VStack(alignment: .leading, spacing: 10) {
      Text(title)
        .foregroundStyle(.accent)
        .font(.poppins(.medium, size: 17))
      Text(subtitle)
        .font(.poppins(.regular, size: 13))
        .foregroundStyle(.gray)
    }
  }
}

#Preview {
  AuthHeaderView(title: "Title", subtitle: "Subtitle with some text.")
}
