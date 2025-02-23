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

enum AuthFieldContent: Hashable {
  case username, phoneNumber, email
}

@MainActor
final class AuthenticationViewModel: ObservableObject {
  
  // MARK: Properties
  @AppStorage("email-link") var emailLink: String?
  @Published var email = ""
  @Published var userSession: FirebaseAuth.User?
  private let userCollection = Firestore.firestore().collection("users")
  
  // MARK: - Form Validation Methods
  func isValidUsername(_ username: String) -> Bool {
    let regex = #"^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: username)
  }
  
  func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
    // works only for ukrainian format.
    let regex = #"^(\+380|0)\d{9}$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: phoneNumber)
  }
  
  func isValidEmail(_ email: String) -> Bool {
    let regex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
    let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)
    return predicate.evaluate(with: email)
  }
  
  // MARK: - Entry Methods
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
  
  func signOut() {
    do {
      try Auth.auth().signOut()
    } catch let signOutError as NSError {
      print("Error signing out: \(signOutError)")
    }
  }
}
