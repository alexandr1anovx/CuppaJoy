//
//  OrderConfiguratorViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 01.07.2025.
//

import Foundation

@MainActor
final class OrderConfiguratorViewModel: ObservableObject {
  
  let selectedCoffee: Coffee
  
  // Order Configuration Settings
  @Published var cupCount: Int = 1
  @Published var sugarSticks: Int = 0
  @Published var iceCubes: Int = 0
  @Published var cupSize: CupSize = .small
  @Published var variety: Variety = .standart
  @Published var milk: Milk = .none
  @Published var flavor: Flavor = .none
  
  // Alerts
  @Published var isShownHintPopover: Bool = false
  @Published var isShownSaveConfigAlert: Bool = false
  
  // Coffee Config Settings
  @Published var configName: String = ""
  @Published var selectedConfig: CoffeeConfig?
  
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
