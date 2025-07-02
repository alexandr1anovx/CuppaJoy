//
//  UserService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.06.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

// MARK: - User Service Protocol

protocol UserServiceProtocol {
  func fetchAppUser(uid: String) async throws -> User?
  func createOrUpdateAppUser(user: User) async throws
  func deleteUserDocument(withPassword: String) async throws
}

final class UserService: UserServiceProtocol {
  
  private let db = Firestore.firestore()
  private let usersCollection: String = "users"
  
  init() { print("UserService INITIALIZED") }
  deinit { print("UserService DEINITIALIZED") }
  
  // MARK: - Public Methods
  
  func fetchAppUser(uid: String) async throws -> User? {
    let documentReference = db.collection(usersCollection).document(uid)
    let document = try await documentReference.getDocument()
    if document.exists {
      return try document.data(as: User.self)
    } else {
      return nil
    }
  }
  
  func createOrUpdateAppUser(user: User) async throws {
    guard let uid = user.id else {
      throw AuthErrorCode.userNotFound
    }
    try db
      .collection(usersCollection)
      .document(uid)
      .setData(from: user, merge: true)
  }
  
  func deleteUserDocument(withPassword password: String) async throws {
    guard let user = Auth.auth().currentUser,
          let email = user.email else {
      throw AuthErrorCode.userNotFound
    }
    let credential = EmailAuthProvider.credential(
      withEmail: email,
      password: password
    )
    try await user.reauthenticate(with: credential)
    try await db
      .collection(usersCollection)
      .document(user.uid)
      .delete()
  }
}

