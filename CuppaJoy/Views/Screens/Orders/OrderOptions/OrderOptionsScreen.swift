//
//  CoffeeOrderScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct OrderOptionsScreen: View {
  
  // MARK: Stored Properties
  let selectedCoffee: Coffee
  @State private var cupQuantity: Int = 1
  @State private var cupSize: CupSize = .small
  @State private var coffeeType: CoffeeType = .arabica
  @State private var milk: Milk = .none
  @State private var syrup: Syrup = .none
  @State private var additive: Additive = .none
  @State private var iceCubeCount: IceCube = .none
  @State private var totalPrice: Double = 0.0
  
  // MARK: Computed Properties
  var calculatedTotalPrice: Double {
    let basePrice = selectedCoffee.price
    let assemblerPrice = cupSize.price + milk.price + syrup.price + additive.price
    let finalPrice = (basePrice + assemblerPrice) * Double(cupQuantity)
    return finalPrice
  }
  
  // MARK: body
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      VStack {
        List {
          QuantityCell(cupQuantity: $cupQuantity)
          CupSizeCell(cupSize: $cupSize)
          CoffeeTypePicker(coffeeType: $coffeeType)
          MilkPicker(milk: $milk)
          SyrupPicker(syrup: $syrup)
          AdditivePicker(additive: $additive)
          IceCubePicker(iceCubeCount: $iceCubeCount)
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(20)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .shadow(radius: 5)
        
        HStack {
          VStack(alignment: .center, spacing: 8) {
            Text("Total Price:")
              .font(.subheadline)
              .fontDesign(.monospaced)
              .foregroundStyle(.gray)
            Text("₴ \(calculatedTotalPrice, specifier: "%.2f")")
              .font(.title2).bold()
              .foregroundStyle(.white)
              .contentTransition(.numericText(value: calculatedTotalPrice))
              .animation(.spring, value: calculatedTotalPrice)
          }
          Spacer()
          NavigationLink {
            PendingOrderScreen(calculatedTotalPrice: calculatedTotalPrice)
          } label: {
            Text("Confirm")
              .font(.callout).bold()
              .fontDesign(.monospaced)
              .foregroundStyle(.accent)
              .padding(16)
              .background(.black)
              .clipShape(.buttonBorder)
          }
        }
        .shadow(radius: 5)
        .padding(20)
        
        // 20px bottom padding for iPhone SE 3rd generation.
        .padding(.bottom, UIScreen.current?.bounds.height == 667 ? 20 : 0)
      }
      .navigationTitle("Order Options")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          ReturnButton()
        }
      }
    }
  }
}

#Preview {
  OrderOptionsScreen(selectedCoffee: .espresso)
}
