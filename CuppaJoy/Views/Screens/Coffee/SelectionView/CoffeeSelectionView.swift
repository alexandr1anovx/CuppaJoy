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
      Color.appBackground
        .clipShape(.rect(cornerRadius: 30))
        .ignoresSafeArea(.all)
      
      VStack {
        Label("Soborna Street, 50A", systemImage: "mappin")
          .font(.footnote)
          .fontDesign(.monospaced)
          .foregroundStyle(.accent)
          .padding(.horizontal, 10)
          .padding(.vertical, 12)
          .background(.csDarkGrey)
          .clipShape(.capsule)
        
        ScrollView {
          LazyVGrid(columns: fixedColumns, spacing: 20) {
            ForEach(Coffee.allCases, id: \.self) { coffee in
              CoffeeCell(coffee: coffee)
            }
          }
          .padding(
            .top, UIScreen.current?.bounds.height == 667 ? 15 : 20
          )
        }
      }
      .padding(.horizontal)
      .padding(.vertical, 20)
    }
  }
}

#Preview {
  CoffeeSelectionView()
}
