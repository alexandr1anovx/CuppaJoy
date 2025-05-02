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

struct ConfigAlertContext {
  
  static let configSuccessfullyDeleted = AlertItem(
    Text("Success!"),
    Text("Config was successfully deleted!"),
    dismissButton: .default(Text("OK"))
  )
  
  static let failedToDeleteConfig = AlertItem(
    Text("Deletion Failed"),
    Text("You cannot delete this config"),
    dismissButton: .default(Text("OK"))
  )
  
}

struct AuthAlertContext {
  
  static let failedToSignIn = AlertItem(
    Text("Failed to Sign In"),
    Text("The user with this email address does not exist."),
    dismissButton: .default(Text("OK"))
  )
  
  static let failedToSignUp = AlertItem(
    Text("Failed to Sign Up"),
    Text("A user with the entered data already exists."),
    dismissButton: .default(Text("OK"))
  )
  
  static let failedToSignOut = AlertItem(
    Text("Failed to Sign Out"),
    Text("Please, contact support for assistance"),
    dismissButton: .default(Text("OK"))
  )
  
  static let failedToDeleteUser = AlertItem(
    Text("Failed to delete account"),
    Text("Please, contact support for assistance"),
    dismissButton: .default(Text("OK"))
  )
  
  // MARK: Account Deletion
  
  static let successfullAccountDeletion = AlertItem(
    Text("Account Successfully Deleted"),
    dismissButton: .default(Text("OK"))
  )
  
  static let unsuccessfullAccountDeletion = AlertItem(
    Text("Failed to Delete Account"),
    Text("An error occurred while trying to delete an account."),
    dismissButton: .default(Text("OK"))
  )
  
  // MARK: Email Update
  
  static let unsuccessfullEmailUpdate = AlertItem(
    Text("Failed to Update Email"),
    Text("This email address is already in use."),
    dismissButton: .default(Text("OK"))
  )
  
  static let confirmationEmailLinkSent = AlertItem(
    Text("Confirmation Link Sent"),
    Text("A confirmation link has been sent to your email address."),
    dismissButton: .default(Text("OK"))
  )
  
  // MARK: Password Recovery
  
  static let passwordResetLinkSent = AlertItem(
    Text("Reset Link Sent"),
    Text("A password reset link has been sent to your email."),
    dismissButton: .default(Text("OK"))
  )
  
  static let passwordResetLinkFailed = AlertItem(
    Text("Failed to Send Reset Link"),
    Text("Failed to send password reset email. Please check your email address and try again."),
    dismissButton: .default(Text("OK"))
  )
  
  // MARK: Profile Update
  
  static let successfulProfileUpdate = AlertItem(
    Text("Profile Updated"),
    Text("Your profile has been successfully updated."),
    dismissButton: .default(Text("OK"))
  )
  
  static let unsuccessfulProfileUpdate = AlertItem(
    Text("Update Failed"),
    Text("Failed to update profile. Please try again."),
    dismissButton: .default(Text("OK"))
  )
  
  static let noChangesInProfile = AlertItem(
    Text("No Changes"),
    Text("No changes were made to your profile."),
    dismissButton: .default(Text("OK"))
  )
}
