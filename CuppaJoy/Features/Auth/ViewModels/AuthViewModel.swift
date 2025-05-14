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
  
  // MARK: - Public Properties
  
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  @Published var alertItem: AlertItem?
  
  // MARK: - Private Properties
  
  private var authStateListener: AuthStateDidChangeListenerHandle?
  private let authService: AuthService
  
  // MARK: - Init / Deinit
  
  init(authService: AuthService = AuthService()) {
    self.authService = authService
    setupAuthStateListener()
  }
  
  deinit {
    if let handle = authStateListener {
      Auth.auth().removeStateDidChangeListener(handle)
    }
  }
  
  // MARK: - Public Methods
  
  func signIn(email: String, password: String) async {
    do {
      try await authService.signIn(email: email, password: password)
    } catch {
      alertItem = AuthAlertContext.userNotExist
    }
  }
  
  func signUp(
    fullName: String,
    email: String,
    password: String,
    city: City
  ) async {
    do {
      let user = try await authService.signUp(email: email, password: password)
      try await authService.sendEmailVerification()
      let newUser = User(
        id: user.uid,
        fullName: fullName,
        emailAddress: email,
        city: city.title,
        coins: Int.random(in: 0...8)
      )
      try await authService.saveUserData(for: newUser)
      self.currentUser = newUser
    } catch {
      alertItem = AuthAlertContext.userExists
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
  
  func updateProfile(fullName: String, email: String, city: City) async {
    guard let currentUser = currentUser else {
      alertItem = AuthAlertContext.profileUpdateFailed
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
      alertItem = AuthAlertContext.profileUpdateSuccess
    } catch {
      alertItem = AuthAlertContext.profileUpdateFailed
    }
  }
  
  func deleteUser(withPassword: String) async {
    do {
      try await authService.deleteUser(withPassword: withPassword)
      self.currentUser = nil
      alertItem = AuthAlertContext.successfullAccountDeletion
    } catch {
      alertItem = AuthAlertContext.failedToDeleteUser
    }
  }
  
  func sendPasswordResetLink(to email: String) async {
    do {
      try await authService.sendPasswordReset(email: email)
      alertItem = AuthAlertContext.passwordResetLinkSent
    } catch {
      alertItem = AuthAlertContext.failedToUpdateEmail
    }
  }

  // MARK: - Private Methods
  
  private func setupAuthStateListener() {
    authStateListener = Auth.auth()
      .addStateDidChangeListener { [weak self] _, user in
        guard let self = self else { return }
        self.userSession = user
        
        if user == nil {
          self.currentUser = nil
        } else {
          Task {
            await self.fetchUserData()
          }
        }
      }
  }
  
  private func fetchUserData() async {
    guard let uid = userSession?.uid else { return }
    do {
      let user = try await authService.fetchUserData(uid: uid)
      self.currentUser = user
    } catch {
      print("‼️ Failed to fetch user data: \(error.localizedDescription)")
    }
  }
}

// MARK: - Preview Mode

extension AuthViewModel {
  static var previewMode: AuthViewModel {
    let viewModel = AuthViewModel()
    viewModel.currentUser = MockData.user
    return viewModel
  }
}
