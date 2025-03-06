//
//  CoffeeOrderScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct OrderConfiguratorScreen: View {
  
  let selectedCoffee: Coffee
  @State private var cupCount = 1
  @State private var sugarSticks = 0
  @State private var iceCubes = 0
  @State private var cupSize: CupSize = .small
  @State private var variety: Variety = .standart
  @State private var milk: Milk = .none
  @State private var flavor: Flavor = .none
  
  var totalPrice: Double {
    let basePrice = selectedCoffee.price
    let configurations = cupSize.price + milk.price + flavor.price
    let total = (basePrice + configurations) * Double(cupCount)
    return total
  }
  
  var order: Order {
    Order(
      id: UUID().uuidString,
      coffee: selectedCoffee.title,
      cupSize: cupSize.title,
      cupCount: cupCount,
      sugarSticks: sugarSticks,
      iceCubes: iceCubes,
      variety: variety.title,
      milk: milk.title,
      flavor: flavor.title,
      timestamp: .now,
      points: selectedCoffee.points,
      totalPrice: totalPrice
    )
  }
  
  // MARK: Body
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
            OrderItemCounter("Sugar sticks:", min: 0, max: 2, count: $sugarSticks)
            OrderItemCounter("Ice cubes:", min: 0, max: 2, count: $iceCubes)
            OrderItemPicker("Variety:", selectedItem: $variety)
            OrderItemPicker("Milk:", selectedItem: $milk)
            OrderItemPicker("Flavor:", selectedItem: $flavor)
          }
        }
        .listStyle(.insetGrouped)
        .listSectionSpacing(8)
        .listRowSpacing(13)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .shadow(radius: 5)
        
        totalAmountLabel
      }
    }
    .navigationTitle("Order Configurator")
    .navigationBarTitleDisplayMode(.inline)
    .onAppear {
      setupSegmentedControlAppearance()
    }
  }
  
  private var totalAmountLabel: some View {
    VStack(spacing: 20) {
      HStack(spacing: 5) {
        Text("Total Amount:")
          .font(.headline)
          .fontWeight(.bold)
          .foregroundStyle(.white)
        Text(order.stringPrice)
          .font(.title3)
          .fontWeight(.bold)
          .foregroundStyle(.csCream)
          .contentTransition(.numericText())
          .animation(.bouncy, value: totalPrice)
          .frame(minWidth: 75)
      }
      NavigationLink {
        OrderSummaryScreen(order: order)
      } label: {
        ButtonLabelAnimated(
          "Summorize",
          textColor: .white,
          bgColor: Color.buttonGradient
        )
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 30)
        .fill(Color.csBlack)
        .ignoresSafeArea(.all)
        .frame(height: 140)
        .shadow(radius: 5)
    )
  }
  
  private func setupSegmentedControlAppearance() {
    let appearance = UISegmentedControl.appearance()
    appearance.selectedSegmentTintColor = .csBrown
    appearance.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    appearance.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    appearance.backgroundColor = .black
  }
}

#Preview {
  OrderConfiguratorScreen(selectedCoffee: MockData.coffee)
    .environmentObject(CoffeeViewModel())
}
