//
//  SelectCoffeeView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.11.2024.
//

import SwiftUI

struct CoffeeSelectionView: View {
  
  let fixedColumns = [
    GridItem(.fixed(UIScreen.current?.bounds.height == 667 ? 130 : 140), spacing: 40),
    GridItem(.fixed(UIScreen.current?.bounds.height == 667 ? 130 : 140))
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



#Preview {
  CoffeeSelectionView()
}
