//
//  CoffeeOrderScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct OrderConfiguratorScreen: View {
  
  let selectedCoffee: CoffeeType
  @State private var cupCount = 1
  @State private var sugarCount = 0
  @State private var iceCount = 0
  @State private var totalPrice = 0.0
  
  @State private var cupSize: CupSize = .small
  @State private var variety: Variety = .arabica
  @State private var milk: Milk = .none
  @State private var flavor: Flavor = .none
  
  var order: Order {
    Order(
      id: "123",
      coffee: selectedCoffee,
      cupSize: cupSize,
      cupCount: cupCount,
      sugarCount: sugarCount,
      iceCount: iceCount,
      variety: variety,
      milk: milk,
      flavor: flavor)
  }
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      VStack {
        List {
          Section("Cup Configurations") {
            OrderItemPickerView("Size", selectedItem: $cupSize)
              .pickerStyle(.segmented)
            OrderItemCountView("Count:", min: 1, max: 4, count: $cupCount)
          }
          Section("Additives") {
            OrderItemCountView("Sugar sticks:", min: 0, max: 2, count: $sugarCount)
            OrderItemCountView("Ice cubes:", min: 0, max: 2, count: $iceCount)
            OrderItemPickerView("Variety:", selectedItem: $variety)
            OrderItemPickerView("Milk:", selectedItem: $milk)
            OrderItemPickerView("Flavor:", selectedItem: $flavor)
          }
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(10)
        .listRowSpacing(15)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .shadow(radius: 5)
        
        totalAmountFooter
        
        // 25px padding for iPhone SE 3rd generation
        // 20px padding for other models.
        .padding(.all, UIScreen.current?.bounds.height == 667 ? 25 : 0)
      }
    }
    .navigationTitle("Order Configurator")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        ReturnButton()
      }
    }
  }
  
  private var totalAmountFooter: some View {
    VStack(spacing: 25) {
      HStack(spacing: 10) {
        Text("Total Price:")
          .font(.system(size: 18))
          .fontWeight(.bold)
          .foregroundStyle(.white)
        Text("₴\(order.totalPrice, specifier: "%.2f")")
          .font(.system(size: 22))
          .fontWeight(.bold)
          .foregroundStyle(.csCream)
          .contentTransition(.numericText())
          .animation(.bouncy, value: order.totalPrice)
      }
      NavigationLink {
        OrderSummaryScreen(order: order)
      } label: {
        ButtonLabel("Summorize", textColor: .white, pouring: .csBrown)
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 35)
        .fill(Color.csBlack)
        .ignoresSafeArea(.all)
        .frame(height: 150)
        .shadow(radius: 5)
    )
  }
}

#Preview {
  OrderConfiguratorScreen(selectedCoffee: .espresso)
}
