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
  private let coffeeCatalogService: CoffeeCatalogService
  
  // MARK: - Init
  
  init(coffeeCatalogService: CoffeeCatalogService = CoffeeCatalogService()) {
    self.coffeeCatalogService = coffeeCatalogService
    fetchCoffees()
  }
  
  // MARK: - Private Methods
  
  private func fetchCoffees() {
    coffeeCatalogService.fetchCoffees { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let coffees):
          self?.coffees = coffees
        case .failure(let error):
          print("❌ Error loading coffees: \(error.localizedDescription)")
        }
      }
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
