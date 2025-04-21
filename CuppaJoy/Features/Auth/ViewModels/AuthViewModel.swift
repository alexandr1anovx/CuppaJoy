//
//  AuthenticationViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import FirebaseAuth
import FirebaseFirestore

@MainActor
final class AuthViewModel: ObservableObject {
  
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  @Published var alertItem: AlertItem?
  
  private var authStateListener: AuthStateDidChangeListenerHandle?
  private let authService = AuthService.shared
  
  // MARK: - Init
  init() {
    setupAuthStateListener()
  }
  
  // MARK: - Public Authentication Methods
  
  func signIn(
    with email: String,
    and password: String
  ) async {
    do {
      let user = try await authService.signIn(
        email: email,
        password: password
      )
      self.userSession = user
      self.currentUser = try await authService.fetchUserData(uid: user.uid)
    } catch {
      alertItem = AuthAlertContext.failedToSignIn
    }
  }
  
  func signUp(
    fullName: String,
    email: String,
    password: String,
    city: City
  ) async {
    do {
      let user = try await authService.signUp(
        email: email,
        password: password
      )
      try await authService.sendEmailVerification()
      let newUser = User(
        id: user.uid,
        fullName: fullName,
        emailAddress: email,
        city: city.title,
        coins: Int.random(in: 0...8)
      )
      try await authService.saveUserData(for: newUser)
      self.userSession = user
      self.currentUser = newUser
    } catch {
      alertItem = AuthAlertContext.failedToSignUp
    }
  }
  
  func signOut() {
    do {
      try authService.signOut()
      currentUser = nil
    } catch {
      alertItem = AuthAlertContext.failedToSignOut
    }
  }
  
  func updateProfile(
    fullName: String,
    email: String,
    city: City
  ) async {
    
    guard let currentUser else {
      alertItem = AuthAlertContext.unsuccessfulProfileUpdate
      return
    }
    
    let updatedUser = User(
      id: currentUser.id,
      fullName: fullName,
      emailAddress: email,
      city: city.title,
      coins: currentUser.coins
    )
    
    do {
      try await authService.saveUserData(for: updatedUser)
      self.currentUser = updatedUser
      alertItem = AuthAlertContext.successfulProfileUpdate
    } catch {
      print("⚠️ Failed to update profile: \(error)")
      alertItem = AuthAlertContext.unsuccessfulProfileUpdate
    }
  }
  
  func deleteUser(password: String) async {
    do {
      try await authService.deleteUser(password: password)
      self.currentUser = nil
    } catch {
      print("⚠️ Failed to delete user: \(error)")
      alertItem = AuthAlertContext.failedToDeleteUser
    }
  }

  // MARK: - Private Authentication Methods
  
  private func setupAuthStateListener() {
    let auth = Auth.auth()
    authStateListener = auth.addStateDidChangeListener { [weak self] _, user in
      guard let self = self else { return }
      self.userSession = user
      
      if user != nil {
        Task { await self.fetchUserData() }
      } else {
        self.currentUser = nil
      }
    }
  }
  
  private func fetchUserData() async {
    guard let uid = userSession?.uid else {
      print("Error when getting user uid")
      return
    }
    do {
      let user = try await authService.fetchUserData(uid: uid)
      self.currentUser = user
    } catch {
      print("⚠️ Failed to get user data: \(error)")
    }
  }
  
}

// MARK: - Preview Mode

extension AuthViewModel {
  static func previewMode() -> AuthViewModel {
    let viewModel = AuthViewModel()
    viewModel.currentUser = MockData.user
    return viewModel
  }
}
