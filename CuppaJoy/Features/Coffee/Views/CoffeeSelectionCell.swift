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
    RoundedRectangle(cornerRadius: 20)
      .foregroundStyle(.csBlack)
      .shadow(radius: 5)
      .aspectRatio(1.1, contentMode: .fit)
      .overlay(alignment: .topLeading) { coinsLabel }
      .overlay(alignment: .topTrailing) { priceLabel }
      .overlay(alignment: .center) { coffeeDataLabel }
  }
  
  private var coinsLabel: some View {
    HStack(spacing: 6) {
      Image(.star)
        .resizable()
        .frame(width: 12, height: 12)
      Text(coffee.stringPoints)
        .font(.caption2)
        .fontWeight(.semibold)
    }
    .foregroundStyle(.orange)
    .padding(8)
    .background(.csDarkGrey)
    .clipShape(.capsule)
    .padding(.leading, 10)
    .padding(.top, 10)
  }
  
  private var priceLabel: some View {
    Text(coffee.stringPrice)
      .font(.subheadline)
      .fontWeight(.semibold)
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
