//
//  AuthenticationViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

// MARK: Enums

enum City: String, CaseIterable {
  case mykolaiv, odesa
  var title: String { rawValue.capitalized }
}

@MainActor
final class AuthenticationViewModel: ObservableObject {
  
  // MARK: Properties
  
  // @AppStorage("email-link") var emailLink: String?
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  @Published var selectedCity: City = .mykolaiv
  
  let userCollection = Firestore.firestore().collection("users")
  
  // MARK: - Initializer
  init() {
    self.userSession = Auth.auth().currentUser
    Task {
      await fetchUser()
    }
  }
  
  // MARK: - Form Validation Methods
  
  func isValidFullName(_ fullName: String) -> Bool {
    let regex = #"^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: fullName)
  }
  
  func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
    // works only for ukrainian format.
    let regex = #"^(\+380|0)\d{9}$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: phoneNumber)
  }
  
  func isValidEmail(_ emailAddress: String) -> Bool {
    let regex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
    let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)
    return predicate.evaluate(with: emailAddress)
  }
  
  func isValidPassword(_ password: String) -> Bool {
    let regex = #"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: password)
  }
  
  // MARK: - Entry Methods
  
  private func fetchUser() async {
    guard let uid = userSession?.uid else {
      print("Error when getting user uid")
      return
    }
    guard let snapshot = try? await userCollection.document(uid).getDocument() else {
      print("Error when getting user document")
      return
    }
    // decode the fetched document into a User object
    self.currentUser = try? snapshot.data(as: User.self)
  }
  
  
  func signIn(email: String, password: String) async {
    do {
      let result = try await Auth.auth().signIn(withEmail: email, password: password)
      self.userSession = result.user
      await fetchUser()
    } catch {
      print("User with this data does not exists.")
    }
  }
  
  func signUp(
    fullName: String,
    email: String,
    password: String,
    city: City
  ) async {
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
        city: city.title
      )
      let encodedUser = try Firestore.Encoder().encode(user)
      let document = userCollection.document(user.id)
      try await document.setData(encodedUser)
      await fetchUser()
    } catch {
      print("This user already exists.")
    }
  }
  
  /*
  func signOut() {
    do {
      try Auth.auth().signOut()
    } catch let signOutError as NSError {
      print("Error signing out: \(signOutError)")
    }
  }
  
   
  func sendSignInLink() async {
    let actionCodeSettings = ActionCodeSettings()
    actionCodeSettings.url = URL(string: "https://www.example.com")
    // The sign-in operation has to always be completed in the app.
    actionCodeSettings.handleCodeInApp = true
    actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
    
    do {
      try await Auth.auth().sendSignInLink(toEmail: email, actionCodeSettings: actionCodeSettings)
    } catch {
      print(error.localizedDescription)
      emailLink = email
    }
  }
  */
  
}
