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
    GridItem(.fixed(UIScreen.current?.bounds.height == 667 ? 160 : 170), spacing: 25),
    GridItem(.fixed(UIScreen.current?.bounds.height == 667 ? 160 : 170))
  ]
  
  var body: some View {
    ZStack {
      Color.appBackground
        .clipShape(.rect(cornerRadius: 30))
        .ignoresSafeArea(.all)
      
      VStack {
        Label("Mykolaiv", image: "marker")
          .font(.footnote)
          .fontWeight(.semibold)
          .foregroundStyle(.white)
          .opacity(0.7)
          .padding(13)
          .background(.csDarkGrey)
          .clipShape(.capsule)
        
        ScrollView {
          LazyVGrid(columns: fixedColumns, spacing: 20) {
            ForEach(coffeeViewModel.coffees, id: \.id) { coffee in
              CoffeeSelectionCell(coffee: coffee)
            }
          }.padding(.top, 15)
        }
      }.padding(.vertical, 20)
    }
  }
}

#Preview {
  CoffeeSelectionContainer()
    .environmentObject( CoffeeViewModel() )
}
