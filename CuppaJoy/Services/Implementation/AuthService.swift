//
//  AuthService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.04.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class AuthService: AuthServiceProtocol {
  
  private let auth = Auth.auth()
  let userCollection = Firestore.firestore().collection("users")
  var currentUser: FirebaseAuth.User? { auth.currentUser }
  
  // MARK: - Private Init
  
  static let shared = AuthService()
  private init() {}
  
  // MARK: - Authentication Methods
  
  func signIn(
    email: String,
    password: String
  ) async throws -> FirebaseAuth.User {
    let result = try await auth.signIn(
      withEmail: email,
      password: password
    )
    return result.user
  }
  
  func signUp(email: String, password: String) async throws -> FirebaseAuth.User {
    let result = try await auth.createUser(
      withEmail: email,
      password: password
    )
    return result.user
  }
  
  func signOut() throws {
    try auth.signOut()
  }
  
  func deleteUser(password: String) async throws {
    guard let user = auth.currentUser, let email = user.email else {
      throw AuthErrorCode.userNotFound
    }
    let credential = EmailAuthProvider.credential(
      withEmail: email,
      password: password
    )
    try await user.reauthenticate(with: credential)
    try await userCollection.document(user.uid).delete()
    try await user.delete()
  }
  
  func sendEmailVerification() async throws {
    try await auth.currentUser?.sendEmailVerification()
  }
  
  func sendPasswordReset(email: String) async throws {
    try await auth.sendPasswordReset(withEmail: email)
  }
  
  func fetchUserData(uid: String) async throws -> User {
    let document = try await userCollection.document(uid).getDocument()
    guard let user = try? document.data(as: User.self) else {
      throw NSError(domain: "UserDecodeError", code: -1)
    }
    return user
  }
  
  func saveUserData(for user: User) async throws {
    let encodedUser = try Firestore.Encoder().encode(user)
    let userDocument = userCollection.document(user.id)
    try await userDocument.setData(encodedUser)
  }
}
