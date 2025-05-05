//
//  AuthServiceProtocol.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.04.2025.
//

import Foundation
import FirebaseAuth

protocol AuthServiceProtocol {
  var currentUser: FirebaseAuth.User? { get }
  
  func signIn(
    email: String,
    password: String
  ) async throws
  
  func signUp(
    email: String,
    password: String
  ) async throws -> FirebaseAuth.User
  
  func sendEmailVerification() async throws
  func signOut() throws
  func deleteUser(withPassword: String) async throws
  func sendPasswordReset(email: String) async throws
  func fetchUserData(uid: String) async throws -> User
  func saveUserData(for user: User) async throws
}
