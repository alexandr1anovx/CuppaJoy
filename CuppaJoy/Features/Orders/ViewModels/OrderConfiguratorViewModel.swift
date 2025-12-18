//
//  OrderConfiguratorViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 01.07.2025.
//

import Foundation

@MainActor
@Observable
final class OrderConfiguratorViewModel {
  let selectedCoffee: Coffee
  
  var cupCount: Int = 1
  var sugarSticks: Int = 0
  var iceCubes: Int = 0
  var cupSize: CupSize = .small
  var variety: Variety = .standart
  var milk: Milk = .none
  var flavor: Flavor = .none
  
  var configName = ""
  var selectedConfig: CoffeeConfig?
  
  var showHintPopover = false
  var showSaveConfigAlert = false
  
  var totalPrice: Double {
    let basePrice = selectedCoffee.price
    let configurations = cupSize.price + milk.price + flavor.price
    let total = (basePrice + configurations) * Double(cupCount)
    return total
  }
  
  var order: Order {
    Order(
      uid: UUID().uuidString,
      coffee: selectedCoffee.title,
      cupSize: cupSize.title,
      cupCount: cupCount,
      sugarSticks: sugarSticks,
      iceCubes: iceCubes,
      variety: variety.title,
      milk: milk.title,
      flavor: flavor.title,
      points: selectedCoffee.points,
      totalPrice: totalPrice,
      timestamp: .now,
      status: "ongoing"
    )
  }
  
  var config: CoffeeConfig {
    CoffeeConfig(
      uid: UUID().uuidString,
      title: configName,
      cupSize: cupSize.title,
      sugarSticks: sugarSticks,
      iceCubes: iceCubes,
      variety: variety.title,
      milk: milk.title,
      flavor: flavor.title
    )
  }
  
  // MARK: - Init
  
  init(selectedCoffee: Coffee) {
    self.selectedCoffee = selectedCoffee
  }
  
  // MARK: - Public Methods
  
  func applyConfig() {
    if let sizeString = selectedConfig?.cupSize,
       let size = CupSize.allCases.first(where: { $0.title == sizeString }) {
      cupSize = size
    }
    
    sugarSticks = selectedConfig?.sugarSticks ?? 0
    iceCubes = selectedConfig?.iceCubes ?? 0
    
    if let varietyString = selectedConfig?.variety,
       let varietyValue = Variety.allCases.first(where: { $0.title == varietyString }) {
      variety = varietyValue
    }
    
    if let milkString = selectedConfig?.milk,
       let milkValue = Milk.allCases.first(where: { $0.title == milkString }) {
      milk = milkValue
    }
    
    if let flavorString = selectedConfig?.flavor,
       let flavorValue = Flavor.allCases.first(where: { $0.title == flavorString }) {
      flavor = flavorValue
    }
  }
}
