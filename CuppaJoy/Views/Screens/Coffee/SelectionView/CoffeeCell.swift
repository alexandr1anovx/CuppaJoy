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
        .fill(Color.cstBrown)
        .aspectRatio(1.2, contentMode: .fit)
        .overlay {
          VStack(spacing: 15) {
            Image(systemName: "cup.and.saucer.fill")
              .resizable()
              .scaledToFit()
              .frame(maxHeight: 45)
            Text(coffee.rawValue)
              .font(.poppins(.medium, size: 14))
          }
          .foregroundStyle(.cstCream)
        }
    }
  }
}

#Preview {
  CoffeeCell(coffee: Coffee.americano)
}
