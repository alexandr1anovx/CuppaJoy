//
//  CoffeeRecipeService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.04.2025.
//

import FirebaseFirestore
import FirebaseAuth

enum RecipeServiceError: Error {
  case userNotLoggedIn
  case missingRecipeID
}

protocol CoffeeRecipeServiceProtocol {
  func fetchRecipes() -> AsyncStream<Result<[CoffeeRecipe], Error>>
  func saveRecipe(_ recipe: CoffeeRecipe) async throws
  func deleteRecipe(_ recipe: CoffeeRecipe) async throws
}

final class CoffeeRecipeService: CoffeeRecipeServiceProtocol {

  private var db = Firestore.firestore()
  
  // MARK: - Public Methods
  
  func fetchRecipes() -> AsyncStream<Result<[CoffeeRecipe], Error>> {
    return AsyncStream { continuation in
      guard let uid = Auth.auth().currentUser?.uid else {
        continuation.yield(.failure(AuthErrorCode.nullUser))
        continuation.finish()
        return
      }
      let listener = recipesCollection(forUserID: uid)
        .addSnapshotListener { snapshot, error in
          if let error {
            continuation.yield(.failure(error))
            return
          }
          guard let documents = snapshot?.documents else {
            continuation.yield(.success([]))
            return
          }
          let recipes = documents.compactMap {
            try? $0.data(as: CoffeeRecipe.self)
          }
          continuation.yield(.success(recipes))
        }
      
      continuation.onTermination = { @Sendable _ in
        listener.remove()
      }
    }
  }
  
  func saveRecipe(_ recipe: CoffeeRecipe) async throws {
    guard let uid = Auth.auth().currentUser?.uid else {
      throw RecipeServiceError.userNotLoggedIn
    }
    try recipesCollection(forUserID: uid)
      .document(recipe.uid)
      .setData(from: recipe)
  }
  
  func deleteRecipe(_ recipe: CoffeeRecipe) async throws {
    guard let uid = Auth.auth().currentUser?.uid else {
      throw RecipeServiceError.userNotLoggedIn
    }
    try await recipesCollection(forUserID: uid)
      .document(recipe.uid)
      .delete()
  }
  
  // MARK: - Private Methods
  
  private func recipesCollection(forUserID uid: String) -> CollectionReference {
    return db
      .collection(FirestoreCollection.users)
      .document(uid)
      .collection(FirestoreCollection.recipes)
  }
}
