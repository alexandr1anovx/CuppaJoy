//
//  CoffeeCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.12.2024.
//

import SwiftUI

struct CoffeeCell: View {
  let coffee: Coffee
  
  var body: some View {
    NavigationLink {
      OrderOptionsScreen(selectedCoffee: coffee)
    } label: {
      RoundedRectangle(cornerRadius: 20)
        .fill(Color.cstCream)
        .aspectRatio(1.1, contentMode: .fit)
        .overlay {
          VStack(spacing: 10) {
            Image(systemName: "cup.and.saucer.fill")
              .resizable()
              .scaledToFit()
              .frame(maxHeight: 50)
            Text(coffee.rawValue)
              .font(.poppins(.medium, size: 15))
          }
          .foregroundStyle(.cstDarkBrown)
        }
    }
  }
}
