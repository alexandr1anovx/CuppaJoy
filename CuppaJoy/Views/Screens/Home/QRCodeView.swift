//
//  QRCodeView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 03.01.2025.
//

import SwiftUI

struct QRCodeView: View {
  var body: some View {
    ZStack {
      Color.mainGradientBackground.ignoresSafeArea()
      
      Image(systemName: "qrcode.viewfinder")
        .resizable()
        .scaledToFit()
        .frame(width: 120, height: 120)
        .foregroundStyle(.gray)
    }
  }
}

#Preview {
  QRCodeView()
}
