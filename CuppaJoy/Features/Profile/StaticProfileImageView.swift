//
//  StaticProfileImageView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 05.04.2025.
//

import SwiftUI

struct StaticProfileImageView: View {
  @State private var profileImage: UIImage? = nil
  
  var body: some View {
    if let profileImage {
      Image(uiImage: profileImage)
        .resizable()
        .scaledToFill()
        .frame(width: 80, height: 80)
        .clipShape(.circle)
    } else {
      Circle()
        .fill(Color.black)
        .frame(width: 80, height: 80)
        .overlay {
          Text("No Image")
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundStyle(.white)
        }
    }
  }
}
