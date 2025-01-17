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
      
      RoundedRectangle(cornerRadius: 25)
        .fill(Color.mainBackgroundGradient)
        .ignoresSafeArea(.all)
      
      VStack {
        Label("Soborna Street, 50B", image: "map")
          .font(.poppins(.medium, size: 14))
          .foregroundStyle(.gray)
        
        ScrollView {
          LazyVGrid(columns: fixedColumns, spacing: 20) {
            ForEach(Coffee.allCases, id: \.self) { coffee in
              CoffeeCell(coffee: coffee)
            }
          }
        }
        .padding(
          .top, UIScreen.current?.bounds.height == 667 ? 15 : 15
        )
      }
      .padding(.vertical, 30)
    }
  }
}

#Preview {
  CoffeeSelectionView()
}
