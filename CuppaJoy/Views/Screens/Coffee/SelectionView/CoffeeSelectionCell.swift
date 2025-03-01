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
        .shadow(radius: 5)
        .aspectRatio(1.1, contentMode: .fit)
      
        .overlay(alignment: .topLeading) { bonuseLabel }
        .overlay(alignment: .topTrailing) { priceLabel }
        .overlay(alignment: .center) { coffeeDataLabel }
    }
  }
  
  private var bonuseLabel: some View {
    Label {
      Text(coffee.stringPoints)
        .font(.caption)
        .fontWeight(.bold)
    } icon: {
      Image(.star)
        .resizable()
        .frame(width: 13, height: 13)
    }
    .foregroundStyle(.white)
    .padding(8)
    .background(
      Color.mainGradient.opacity(0.2)
    )
    .clipShape(.capsule)
    .padding(.leading, 10)
    .padding(.top, 10)
  }
  
  private var priceLabel: some View {
    Text(coffee.stringPrice)
      .font(.subheadline)
      .fontWeight(.bold)
      .foregroundStyle(.csCream)
      .padding(5)
      .background(.csDarkGrey)
      .clipShape(.capsule)
      .padding(.top, 10)
      .padding(.trailing, 10)
      .shadow(radius: 5)
  }
  
  private var coffeeDataLabel: some View {
    VStack(spacing: 8) {
      Text(coffee.title)
        .font(.headline)
        .fontWeight(.bold)
        .foregroundStyle(.white)
      Text(coffee.description)
        .font(.caption2)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
        .multilineTextAlignment(.center)
        .padding(.horizontal)
    }
  }
}

#Preview {
  CoffeeSelectionCell(coffee: MockData.coffee)
}
