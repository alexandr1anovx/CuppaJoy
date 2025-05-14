//
//  CoffeeServiceProtocol.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 24.04.2025.
//

protocol CoffeeCatalogServiceProtocol {
  func fetchCoffees(completion: @escaping (Result<[Coffee], Error>) -> Void)
}
