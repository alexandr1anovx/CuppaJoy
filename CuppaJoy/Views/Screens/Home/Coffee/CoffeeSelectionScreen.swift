//
//  SelectCoffeeView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.11.2024.
//

import SwiftUI

struct CoffeeSelectionScreen: View {
  
  let fixedColumns = [
    GridItem(.fixed(
      UIScreen.current?.bounds.height == 667 ? 130 : 140), spacing: 40),
    GridItem(.fixed(
      UIScreen.current?.bounds.height == 667 ? 130 : 140))
  ]
  
  var body: some View {
    ZStack {
      TopRoundedRectangle(cornerRadius: 25)
        .fill(Color.cstDarkBrown)
        .ignoresSafeArea()
      ScrollView {
        LazyVGrid(columns: fixedColumns, spacing: 25) {
          ForEach(Coffee.allCases, id: \.self) { coffee in
            CoffeeCell(coffee: coffee)
          }
        }
        .padding(.top, UIScreen.current?.bounds.height == 667 ? 25 : 50)
      }
    }
  }
}

struct CoffeeCell: View {
  let coffee: Coffee
  
  var body: some View {
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

#Preview {
  CoffeeSelectionScreen()
}

