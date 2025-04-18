//
//  AuthenticationViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import FirebaseAuth
import FirebaseFirestore

enum City: String, Identifiable, CaseIterable {
  case mykolaiv, odesa
  
  var id: Self { self }
  var title: String { rawValue.capitalized }
}

@MainActor
final class AuthViewModel: ObservableObject {
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  @Published var selectedCity: City = .mykolaiv
  @Published var alertItem: AlertItem?
  
  private let userCollection = Firestore.firestore().collection("users")
  
  // MARK: - Init
  init() {
    self.userSession = Auth.auth().currentUser
    Task {
      await fetchUser()
    }
  }
  
  // MARK: - Form Validation Methods
  
  func isValid(fullName: String) -> Bool {
    let regex = #"^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: fullName)
  }
  
  func isValid(phoneNumber: String) -> Bool {
    // works only for ukrainian format.
    let regex = #"^(\+380|0)\d{9}$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: phoneNumber)
  }
  
  func isValid(email: String) -> Bool {
    let regex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
    let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)
    return predicate.evaluate(with: email)
  }
  
  func isValid(password: String) -> Bool {
    let regex = #"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: password)
  }
  
  // MARK: - Public Authentication Methods
  
  func signIn(with email: String, and password: String) async {
    do {
      let result = try await Auth.auth().signIn(
        withEmail: email,
        password: password
      )
      self.userSession = result.user
      await fetchUser()
    } catch {
      alertItem = AuthAlertContext.failedToSignIn
    }
  }
  
  func signUp(fullName: String, email: String, password: String, city: City) async {
    do {
      let result = try await Auth.auth().createUser(
        withEmail: email,
        password: password
      )
      self.userSession = result.user
      try await result.user.sendEmailVerification()
      let user = User(
        id: result.user.uid,
        fullName: fullName,
        emailAddress: email,
        city: city.title,
        coins: Int.random(in: 0...8)
      )
      let encodedUser = try Firestore.Encoder().encode(user)
      let document = userCollection.document(user.id)
      try await document.setData(encodedUser)
      await fetchUser()
    } catch {
      alertItem = AuthAlertContext.failedToSignUp
    }
  }
  
  func signOut() {
    do {
      try Auth.auth().signOut()
      self.userSession = nil
      self.currentUser = nil
    } catch {
      alertItem = AuthAlertContext.failedToSignOut
    }
  }
  
  func deleteUser(with password: String) async throws {
    do {
      guard let user = userSession else { throw AuthErrorCode.userNotFound }
      guard let userEmail = user.email else { throw AuthErrorCode.invalidEmail }
      
      let userCredentials = EmailAuthProvider.credential(withEmail: userEmail, password: password)
      try await user.reauthenticate(with: userCredentials)
      let userRef = userCollection.document(user.uid)
      try await userRef.delete()
      try await user.delete()
      
      userSession = nil
      currentUser = nil
    } catch {
      print("Cannot delete user: \(error.localizedDescription)")
    }
  }
  
  func sendPasswordResetLink(to email: String) async {
    do {
      try await Auth.auth().sendPasswordReset(withEmail: email)
      alertItem = AuthAlertContext.passwordResetLinkSent
    } catch {
      alertItem = AuthAlertContext.passwordResetLinkFailed
    }
  }
  
  // MARK: - Public Methods
  
  func addCoinsToUser(_ coins: Int) async {
    guard let uid = userSession?.uid else {
      print("Error when getting user uid")
      return
    }
    let userRef = userCollection.document(uid)
    
    do {
      let snapshot = try await userRef.getDocument()
      if let userData = snapshot.data(), let currentCoins = userData["coins"] as? Int {
        let updatedCoins = currentCoins + coins
        try await userRef.updateData(["coins": updatedCoins])
        print("Coins updated successfully! New balance: \(updatedCoins)")
        
        DispatchQueue.main.async {
          self.currentUser?.coins = updatedCoins
        }
      }
    } catch {
      print("Error updating coins: \(error)")
    }
  }
  
  // MARK: - Private Methods
  
  private func fetchUser() async {
    guard let uid = userSession?.uid else {
      print("Error when getting user uid")
      return
    }
    guard let snapshot = try? await userCollection.document(uid).getDocument() else {
      print("Error when getting user document")
      return
    }
    // Decode the fetched document into a User object.
    self.currentUser = try? snapshot.data(as: User.self)
  }
  
  // MARK: - Profile Update Methods
  
  func updateProfile(fullName: String, email: String, city: City) async {
    guard let user = userSession, let currentUser = currentUser else {
      alertItem = AuthAlertContext.unsuccessfulProfileUpdate
      return
    }
    
    // Check if any data has changed
    let hasChanges = fullName != currentUser.fullName ||
                    email != currentUser.emailAddress ||
                    city.title != currentUser.city
    
    guard hasChanges else {
      alertItem = AuthAlertContext.noChangesInProfile
      return
    }
    
    // Validate input data
    guard isValid(fullName: fullName) else {
      alertItem = AuthAlertContext.unsuccessfulProfileUpdate
      return
    }
    
    do {
      // If email has changed, update Firebase Auth email
      if email != currentUser.emailAddress {
        guard isValid(email: email) else {
          alertItem = AuthAlertContext.unsuccessfulProfileUpdate
          return
        }
        try await user.sendEmailVerification()
      }
      
      // Update Firestore document
      let updatedUser = User(
        id: currentUser.id,
        fullName: fullName,
        emailAddress: email,
        city: city.title,
        coins: currentUser.coins
      )
      
      let encodedUser = try Firestore.Encoder().encode(updatedUser)
      try await userCollection.document(user.uid).setData(encodedUser)
      
      // Update local state
      self.currentUser = updatedUser
      alertItem = AuthAlertContext.successfulProfileUpdate
    } catch {
      print("Failed to update profile: \(error.localizedDescription)")
      alertItem = AuthAlertContext.unsuccessfulProfileUpdate
    }
  }
}

// MARK: Preview Mode

extension AuthViewModel {
  static func previewMode() -> AuthViewModel {
    let viewModel = AuthViewModel()
    viewModel.currentUser = User(
      id: "mockID",
      fullName: "Full Name",
      emailAddress: "preview@example.com",
      city: "City",
      coins: 10
    )
    return viewModel
  }
}
