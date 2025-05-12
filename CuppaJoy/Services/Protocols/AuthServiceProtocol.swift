//
//  AuthServiceProtocol.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.04.2025.
//

import FirebaseAuth

protocol AuthServiceProtocol {
  func signIn(email: String, password: String) async throws
  func signUp(email: String, password: String) async throws -> FirebaseAuth.User
  func signOut() throws
  func deleteUser(withPassword: String) async throws
  func sendEmailVerification() async throws
  func sendPasswordReset(email: String) async throws
  func fetchUserData(uid: String) async throws -> User
  func saveUserData(for user: User) async throws
}
