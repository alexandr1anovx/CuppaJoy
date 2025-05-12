//
//  CoffeeViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 26.02.2025.
//

import Foundation

@MainActor
final class CoffeeCatalogViewModel: ObservableObject {
  
  // MARK: Public Properties
  @Published var coffees: [Coffee] = []
  
  // MARK: Private Properties
  private let coffeeCatalogService: CoffeeСatalogService
  
  // MARK: Initializer
  init(coffeeCatalogService: CoffeeСatalogService = CoffeeСatalogService()) {
    self.coffeeCatalogService = coffeeCatalogService
    setupBindings()
    fetchCoffees()
  }
  
  // MARK: Public Methods
  func fetchCoffees() {
    coffeeCatalogService.getCoffees()
  }
  
  // MARK: Private Methods
  private func setupBindings() {
    coffeeCatalogService.$coffees
      .receive(on: DispatchQueue.main)
      .assign(to: &$coffees)
  }
}
