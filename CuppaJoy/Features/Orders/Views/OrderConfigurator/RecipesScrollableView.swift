//
//  RecipesScrollableView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 01.07.2025.
//

import SwiftUI

struct RecipesScrollableView: View {
  
  @Environment(CoffeeRecipeViewModel.self) var coffeeRecipeViewModel
  @Environment(OrderConfiguratorViewModel.self) var orderConfigViewModel
  
  var body: some View {
    HStack {
      Text("My Saved Recipes")
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.white)
      ScrollView(.horizontal) {
        HStack(spacing: 10) {
          ForEach(coffeeRecipeViewModel.recipes) { recipe in
            Button {
              orderConfigViewModel.selectedRecipe = recipe
              orderConfigViewModel.applyRecipe()
            } label: {
              CapsuleLabelCompact(
                recipe.title,
                textColor: .orange,
                bgColor: .csDarkGrey
              )
            }
            .contextMenu {
              Group {
                Button("Delete", systemImage: "trash") {
                  Task {
                    await coffeeRecipeViewModel.deleteRecipe(recipe)
                  }
                }
              }
            }
          }
        }
      }
      Button {
        orderConfigViewModel.showSaveRecipeAlert.toggle()
      } label: {
        Image(systemName: "plus.circle")
          .foregroundStyle(.orange)
          .padding(8)
          .background(.csDarkGrey)
          .clipShape(.circle)
          .shadow(radius: 3)
      }
    }.padding(.horizontal, 20)
  }
}
