//
//  AuthService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.04.2025.
//

import FirebaseFirestore
import FirebaseAuth

final class AuthService: AuthServiceProtocol {
  
  // MARK: - Private Initializer
  
  private let database = Firestore.firestore()
  
  // MARK: - Public Methods
  
  func signIn(email: String, password: String) async throws {
    try await Auth.auth().signIn(withEmail: email, password: password)
  }
  
  func signUp(email: String, password: String) async throws -> FirebaseAuth.User {
    let authResult = try await Auth.auth().createUser(
      withEmail: email, password: password
    )
    return authResult.user
  }
  
  func signOut() throws {
    try Auth.auth().signOut()
  }
  
  func deleteUser(withPassword: String) async throws {
    guard let user = Auth.auth().currentUser,
            let email = user.email else {
      throw AuthErrorCode.userNotFound
    }
    let credential = EmailAuthProvider.credential(
      withEmail: email, password: withPassword
    )
    try await user.reauthenticate(with: credential)
    
    try await database
      .collection("users")
      .document(user.uid)
      .delete() // deletes a user from the collection
    try await user.delete() // deletes a user from the authentication section
  }
  
  func saveUserData(for user: User) async throws {
    let encodedUser = try Firestore.Encoder().encode(user)
    let userDocument = database
      .collection("users")
      .document(user.id)
    try await userDocument.setData(encodedUser)
  }
  
  func sendEmailVerification() async throws {
    try await Auth.auth().currentUser?.sendEmailVerification()
  }
  
  func sendPasswordReset(email: String) async throws {
    try await Auth.auth().sendPasswordReset(withEmail: email)
  }
  
  func fetchUserData(uid: String) async throws -> User {
    let document = try await database
      .collection("users")
      .document(uid)
      .getDocument()
    
    guard let user = try? document.data(as: User.self) else {
      throw NSError()
    }
    return user
  }
}
