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
    VStack(alignment: .leading, spacing: 15) {
      Text(title)
        .font(.title2)
        .fontWeight(.bold)
        .fontDesign(.rounded)
        .foregroundStyle(.accent)
      Text(subtitle)
        .font(.system(size: 14))
        .fontDesign(.rounded)
        .foregroundStyle(.white)
        .opacity(0.6)
    }
  }
}

#Preview {
  AuthHeaderView(title: "Title", subtitle: "Subtitle with some text.")
}
