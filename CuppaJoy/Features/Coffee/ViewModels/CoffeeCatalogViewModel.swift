//
//  CoffeeViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 26.02.2025.
//

import Foundation

@MainActor
final class CoffeeCatalogViewModel: ObservableObject {
  
  @Published var coffees: [Coffee] = []
  private let coffeeCatalogService: CoffeeCatalogServiceProtocol
  
  // MARK: - Init
  
  init(coffeeCatalogService: CoffeeCatalogServiceProtocol = CoffeeCatalogService()) {
    self.coffeeCatalogService = coffeeCatalogService
  }
  
  // MARK: - Private Methods
  
  func fetchCoffees() async {
    do {
      coffees = try await coffeeCatalogService.fetchCoffees()
    } catch {
      print("Failed to fetch coffees from the catalog: \(error.localizedDescription)")
    }
  }
}

extension CoffeeCatalogViewModel {
  static var previewMode: CoffeeCatalogViewModel {
    let viewModel = CoffeeCatalogViewModel()
    viewModel.coffees = [MockData.coffee]
    return viewModel
  }
}
