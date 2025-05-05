//
//  CoffeeViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 26.02.2025.
//

import Foundation
import Combine

@MainActor
final class CoffeeCatalogViewModel: ObservableObject {
  
  @Published var coffees: [Coffee] = []
  private let coffeeService = CoffeeСatalogService.shared
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    Task { await setupBindings() }
  }
  
  func fetchCoffees() async {
    do {
      try await coffeeService.fetchCoffees()
    } catch {
      print("⚠️ Failed to fetch coffees: \(error)")
    }
  }
  
  private func setupBindings() async {
    do {
      try await coffeeService.fetchCoffees()
      Timer.publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
        .sink { [weak self] _ in
          guard let self = self else { return }
          self.coffees = self.coffeeService.coffees
        }
        .store(in: &cancellables)
    } catch {
      print("⚠️ Cannot setup bindings")
    }
  }
}

// MARK: - Preview Mode

extension CoffeeCatalogViewModel {
  static func previewMode() -> CoffeeCatalogViewModel {
    let viewModel = CoffeeCatalogViewModel()
    //viewModel.coffees = [MockData.coffee, MockData.coffee]
    return viewModel
  }
}
