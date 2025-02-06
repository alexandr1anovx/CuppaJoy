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
      RoundedRectangle(cornerRadius: 23)
        .foregroundStyle(.csBlack)
        .shadow(radius: 8)
        .aspectRatio(1.1, contentMode: .fit)
        .overlay {
          VStack(spacing: 15) {
            Image(systemName: "cup.and.saucer.fill")
              .font(.largeTitle)
              .foregroundStyle(.csDesert)
            Text(coffee.title)
              .font(.headline)
              .fontDesign(.monospaced)
              .foregroundStyle(.csDesert)
          }
          .foregroundStyle(.csDesert)
        }
    }
  }
}

#Preview {
  CoffeeCell(coffee: Coffee.americano)
}
