//
//  AuthService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.06.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// MARK: - Auth Service Protocol

protocol AuthServiceProtocol {
  func signIn(email: String, password: String) async throws -> FirebaseAuth.User
  func signUp(email: String, password: String) async throws -> FirebaseAuth.User
  func signOut() throws
  func deleteAccount() async throws
}

final class AuthService: AuthServiceProtocol {
  
  init() {
    print("✅ AuthService INITIALIZED")
  }
  deinit {
    print("❌ AuthService DEINITIALIZED")
  }
  
  // MARK: - Public Methods
  
  func signIn(email: String, password: String) async throws -> FirebaseAuth.User {
    let result = try await Auth.auth().signIn(
      withEmail: email,
      password: password
    )
    return result.user
  }
  
  func signUp(email: String, password: String) async throws -> FirebaseAuth.User {
    let result = try await Auth.auth().createUser(
      withEmail: email,
      password: password
    )
    return result.user
  }
  
  func signOut() throws {
    try Auth.auth().signOut()
  }
  
  func deleteAccount() async throws {
    guard let user = Auth.auth().currentUser else {
      throw AuthErrorCode.userNotFound
    }
    try await user.delete()
  }
}
