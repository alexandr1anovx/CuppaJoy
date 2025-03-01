//
//  SelectCoffeeView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.11.2024.
//

import SwiftUI

struct CoffeeSelectionContainer: View {
  
  @EnvironmentObject var coffeeViewModel: CoffeeViewModel
  
  let fixedColumns = [
    GridItem(
      .fixed(UIScreen.current?.bounds.height == 667 ? 160 : 175), spacing: 20),
    GridItem(
      .fixed(UIScreen.current?.bounds.height == 667 ? 160 : 175))
  ]
  
  var body: some View {
    ZStack {
      Color.appBackground
        .clipShape(.rect(cornerRadius: 35))
        .ignoresSafeArea(.all)
      
      VStack {
        Label("Mykolaiv", image: "marker")
          .font(.footnote)
          .fontWeight(.semibold)
          .foregroundStyle(.accent)
          .padding(12)
          .background(.csDarkGrey)
          .clipShape(.capsule)
        
        ScrollView {
          LazyVGrid(columns: fixedColumns, spacing: 20) {
            ForEach(coffeeViewModel.coffees, id: \.id) { coffee in
              CoffeeSelectionCell(coffee: coffee)
            }
          }.padding(.top, 20)
        }
      }.padding(.vertical, 20)
    }.shadow(radius: 8)
  }
}

#Preview {
  CoffeeSelectionContainer()
    .environmentObject( CoffeeViewModel() )
}
