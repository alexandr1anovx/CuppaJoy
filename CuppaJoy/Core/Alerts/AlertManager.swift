//
//  AlertManager.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 23.03.2025.
//

import SwiftUI

struct AlertItem: Identifiable {
  let id = UUID()
  let title: Text
  let message: Text?
  let dismissButton: Alert.Button
  
  init(
    _ title: Text,
    _ message: Text? = nil,
    dismissButton: Alert.Button
  ) {
    self.title = title
    self.message = message
    self.dismissButton = dismissButton
  }
}

// MARK: - Config Alert Context

struct ConfigAlertContext {
  static let configDeletionSuccess = AlertItem(
    Text("😊 Config was successfully deleted!"),
    dismissButton: .default(Text("OK"))
  )
  static let configDeletionFailed = AlertItem(
    Text("😞 Failed to delete config"),
    Text("An error occurred. Try again, or contact support."),
    dismissButton: .default(Text("OK"))
  )
}

// MARK: - Auth Alert Context

struct AuthAlertContext {
  
  static let userExists = AlertItem(
    Text("🙃 Something went wrong..."),
    Text("The user with the entered data already exists."),
    dismissButton: .default(Text("OK"))
  )
  
  static let userNotExist = AlertItem(
    Text("🙃 Something went wrong"),
    Text("The user with the entered data does not exist."),
    dismissButton: .default(Text("OK"))
  )
  
//  static let failedToSignIn = AlertItem(
//    Text("⚠️ Failed to Sign In!"),
//    Text("The user with this email address does not exist."),
//    dismissButton: .default(Text("OK"))
//  )
  
//  static let failedToSignUp = AlertItem(
//    Text("⚠️ Failed to Sign Up!"),
//    Text("A user with the entered data already exists."),
//    dismissButton: .default(Text("OK"))
//  )
  
  static let failedToSignOut = AlertItem(
    Text("🙃 Failed to Sign Out"),
    Text("Please, contact our support for assistance."),
    dismissButton: .default(Text("OK"))
  )
  
  static let failedToDeleteUser = AlertItem(
    Text("🙃 Failed to delete account"),
    Text("Please, contact our support for assistance."),
    dismissButton: .default(Text("OK"))
  )
  
  // MARK: Account Deletion
  
  static let successfullAccountDeletion = AlertItem(
    Text("😊 Success!"),
    Text("All your data has been deleted."),
    dismissButton: .default(Text("OK"))
  )
  
  // MARK: Email Update
  
  static let failedToUpdateEmail = AlertItem(
    Text("🙃 Failed to Update Email"),
    Text("This email address is already in use."),
    dismissButton: .default(Text("OK"))
  )
  
  // MARK: Password Recovery
  
  static let passwordResetLinkSent = AlertItem(
    Text("Reset Link Sent"),
    Text("A password reset link has been sent to your email."),
    dismissButton: .default(Text("OK"))
  )
  
  // MARK: Profile Update
  
  static let profileUpdateSuccess = AlertItem(
    Text("😊 Success!"),
    Text("Your profile has been successfully updated."),
    dismissButton: .default(Text("OK"))
  )
  
  static let profileUpdateFailed = AlertItem(
    Text("🙃 Something went wrong..."),
    Text("An error occurred while deletion your account. Try again, or contact support."),
    dismissButton: .default(Text("OK"))
  )
}
