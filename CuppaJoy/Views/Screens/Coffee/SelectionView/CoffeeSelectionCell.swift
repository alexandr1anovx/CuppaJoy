//
//  CoffeeCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.12.2024.
//

import SwiftUI

struct CoffeeSelectionCell: View {
  
  let coffee: Coffee
  
  var body: some View {
    NavigationLink {
      OrderConfiguratorScreen(selectedCoffee: coffee)
    } label: {
      RoundedRectangle(cornerRadius: 20)
        .foregroundStyle(.csBlack)
        .shadow(radius: 8)
        .aspectRatio(1.1, contentMode: .fit)
        .overlay(alignment: .top) {
          ratingAndPriceView
        }
        .overlay(alignment: .center) {
          coffeeDataView
        }
    }
  }
  
  private var ratingAndPriceView: some View {
    HStack(spacing: 0) {
      Label(coffee.formattedRating, image: "star")
        .font(.caption)
        .foregroundStyle(.brown)
      Spacer()
      Text(coffee.formattedPrice)
        .font(.subheadline)
        .foregroundStyle(.orange)
        .padding(5)
        .background(.csDarkGrey)
        .clipShape(.capsule)
    }
    .padding(12)
    .fontWeight(.bold)
    .shadow(radius: 5)
  }
  
  private var coffeeDataView: some View {
    VStack(spacing: 8) {
      Text(coffee.title)
        .font(.headline)
        .fontWeight(.bold)
        .foregroundStyle(.csCream)
      Text(coffee.description)
        .font(.caption2)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
        .multilineTextAlignment(.center)
    }
    .padding(10)
  }
}
