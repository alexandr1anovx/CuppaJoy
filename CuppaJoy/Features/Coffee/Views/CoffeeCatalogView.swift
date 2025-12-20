//
//  SelectCoffeeView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.11.2024.
//

import SwiftUI

struct CoffeeCatalogView: View {
  
  @Binding var path: NavigationPath
  @Binding var isTabBarVisible: Bool
  @State private var selectedCoffee: Coffee?
  @EnvironmentObject var viewModel: CoffeeCatalogViewModel
  
  private let fixedColumns = [
    GridItem(
      .fixed(UIScreen.current?.bounds.height == 667 ? 160 : 175), spacing: 20),
    GridItem(
      .fixed(UIScreen.current?.bounds.height == 667 ? 160 : 175))
  ]
  
  var body: some View {
    ZStack {
      Color.appBackgroundDimmed
        .clipShape(.rect(cornerRadius: 35))
        .ignoresSafeArea()
      ScrollView {
        LazyVGrid(columns: fixedColumns, spacing: 20) {
          ForEach(viewModel.coffees, id: \.self) { coffee in
            NavigationLink(value: OrderPage.configurator(coffee)) {
              CoffeeCatalogCell(coffee: coffee)
            }
          }
        }.padding(.vertical, 30)
      }
    }
    .shadow(radius: 8)
    .task {
      if viewModel.coffees.isEmpty {
        await viewModel.fetchCoffees()
      }
    }
  }
}
