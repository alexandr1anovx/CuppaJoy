//
//  BaristaSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

struct BaristaCell: View {
  
  var body: some View {
    HStack(spacing: 20) {
      
      Image("snoop")
        .resizable()
        .scaledToFit()
        .frame(width: 50)
        .background(
          RoundedRectangle(cornerRadius: 15)
            .fill(Color.cstCream)
            .frame(width: 55, height: 55)
        )
      
      VStack(alignment: .leading, spacing: 10) {
        Text("Snoop Dogg")
          .font(.poppins(.bold, size: 17))
          .foregroundStyle(.cstWhite)
        Text("Top barista")
          .font(.poppins(.regular, size: 14))
          .foregroundStyle(.cstGray)
      }
      
      Spacer()
      
      Circle()
        .fill(Color.cstMint)
        .frame(width: 18, height: 18)
    }
  }
}



#Preview {
  BaristaScreen()
}
