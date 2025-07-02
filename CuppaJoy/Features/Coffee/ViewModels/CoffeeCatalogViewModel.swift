//
//  CoffeeViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 26.02.2025.
//

import Foundation

@MainActor
final class CoffeeCatalogViewModel: ObservableObject {
  
  // MARK: - Properties
  
  @Published var coffees: [Coffee] = []
  private let coffeeCatalogService: CoffeeCatalogServiceProtocol
  
  // MARK: - Init
  
  init(coffeeCatalogService: CoffeeCatalogServiceProtocol = CoffeeCatalogService()) {
    self.coffeeCatalogService = coffeeCatalogService
    print("✅ Coffee Catalog View Model INITIALIZED")
  }
  deinit {
    print("❌ Coffee Catalog View Model DEINITIALIZED")
  }
  
  // MARK: - Private Methods
  
  func fetchCoffees() async {
    do {
      coffees = try await coffeeCatalogService.fetchCoffees()
    } catch {
      print("❌ Coffee Catalog View Model: Failed to fetch coffees: \(error.localizedDescription)")
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
