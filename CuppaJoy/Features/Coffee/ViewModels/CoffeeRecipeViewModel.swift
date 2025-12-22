//
//  CoffeeRecipeViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 18.04.2025.
//

import Foundation
import FirebaseAuth

@Observable
final class CoffeeRecipeViewModel {
  
  var recipes: [CoffeeRecipe] = []
  var alertItem: AlertItem?
  
  private let coffeeRecipeService: CoffeeRecipeServiceProtocol
  private var subscriptionTask: Task<Void, Never>?
  
  // MARK: - Init / Deinit
  
  init(coffeeRecipeService: CoffeeRecipeServiceProtocol) {
    self.coffeeRecipeService = coffeeRecipeService
    subscribeToRecipes()
  }
  
  deinit {
    subscriptionTask?.cancel()
  }
  
  // MARK: - Public Methods
  
  func saveRecipe(_ recipe: CoffeeRecipe) async {
    do {
      try await coffeeRecipeService.saveRecipe(recipe)
    } catch {
      print("Failed to save recipe: \(error.localizedDescription)")
    }
  }
  
  func deleteRecipe(_ recipe: CoffeeRecipe) async {
    do {
      try await coffeeRecipeService.deleteRecipe(recipe)
    } catch {
      print("Failed to delete config: \(error.localizedDescription)")
      alertItem = Alerts.CoffeeRecipe.deletionFailed
    }
  }
  
  // MARK: - Private Methods
  
  private func subscribeToRecipes() {
    subscriptionTask?.cancel()
    subscriptionTask = Task {
      let stream = coffeeRecipeService.fetchRecipes()
      
      for await result in stream {
        switch result {
        case .success(let recipes):
          self.recipes = recipes
        case .failure(let error):
          print("Failed to load favorite recipes: \(error.localizedDescription)")
        }
      }
    }
  }
}
