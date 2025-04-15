//
//  SelectCoffeeView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.11.2024.
//

import SwiftUI

struct CoffeeSelectionView: View {
  
  @State private var selectedCoffee: Coffee?
  @Binding var path: NavigationPath
  @Binding var isTabBarVisible: Bool
  @EnvironmentObject var coffeeViewModel: CoffeeViewModel
  @EnvironmentObject var authViewModel: AuthViewModel
  
  private let fixedColumns = [
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
        if let user = authViewModel.currentUser {
          ButtonLabelWithIconShort(
            user.city,
            icon: "building.2.crop.circle.fill",
            textColor: .accent,
            bgColor: .csDarkGrey
          )
          ScrollView {
            LazyVGrid(columns: fixedColumns, spacing: 20) {
              ForEach(coffeeViewModel.coffees, id: \.id) { coffee in
                NavigationLink(value: OrderPage.configurator(coffee)) {
                  CoffeeSelectionCell(coffee: coffee)
                }
              }
            }.padding(.top, 20)
          }
        } else {
          ProgressView()
        }
      }.padding(.vertical, 20)
    }.shadow(radius: 8)
  }
}

#Preview {
  CoffeeSelectionView(
    path: .constant(NavigationPath()),
    isTabBarVisible: .constant(false)
  )
  .environmentObject(AuthViewModel.previewMode())
  .environmentObject(CoffeeViewModel.previewMode())
}
