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

@MainActor
final class AuthenticationViewModel: ObservableObject {
  
  // MARK: Properties
  @AppStorage("email-link") var emailLink: String?
  @Published var email = ""
  @Published var userSession: FirebaseAuth.User?
  private let userCollection = Firestore.firestore().collection("users")
  
  
  // MARK: Public Methods
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
