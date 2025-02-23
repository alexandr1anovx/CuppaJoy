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
  @State private var variety: Variety = .standart
  @State private var milk: Milk = .none
  @State private var flavor: Flavor = .none
  
  var order: Order {
    Order(
      id: "123", // the item ID creation will be changed in the future.
      coffee: selectedCoffee,
      cupSize: cupSize,
      cupCount: cupCount,
      sugarSticks: sugarCount,
      iceCount: iceCount,
      variety: variety,
      milk: milk,
      flavor: flavor,
      timestamp: .now // save the order data to firebase in the future
    )
  }
  
  // MARK: Initializer
  init(selectedCoffee: CoffeeType) {
    self.selectedCoffee = selectedCoffee
    
    // Custom Picker Style
    UISegmentedControl.appearance().selectedSegmentTintColor = .csBrown
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    UISegmentedControl.appearance().backgroundColor = .black
  }
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      VStack {
        List {
          Section("Cup Configurations") {
            OrderItemPicker("Size", selectedItem: $cupSize)
              .pickerStyle(.segmented)
            OrderItemCounter("Count:", min: 1, max: 4, count: $cupCount)
          }
          Section("Additives") {
            OrderItemCounter("Sugar sticks:", min: 0, max: 2, count: $sugarCount)
            OrderItemCounter("Ice cubes:", min: 0, max: 2, count: $iceCount)
            OrderItemPicker("Variety:", selectedItem: $variety)
            OrderItemPicker("Milk:", selectedItem: $milk)
            OrderItemPicker("Flavor:", selectedItem: $flavor)
          }
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(10)
        .listRowSpacing(15)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .shadow(radius: 5)
        
        totalAmountFooter
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
        Text("Total amount:")
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
      RoundedRectangle(cornerRadius: 30)
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
