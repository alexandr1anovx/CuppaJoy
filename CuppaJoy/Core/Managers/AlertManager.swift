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
    _ titleKey: LocalizedStringKey,
    _ messageKey: LocalizedStringKey? = nil,
    dismissButton: Alert.Button
  ) {
    self.title = Text(titleKey)
    if let messageKey = messageKey {
      self.message = Text(messageKey)
    } else {
      self.message = nil
    }
    self.dismissButton = dismissButton
  }
}

struct Alerts {
  
  // MARK: - Authentication
  
  struct Auth {
    static let registrationFailed = AlertItem(
      "Registration Failed",
      "An account with this email address already exists. Please try to log in.",
      dismissButton: .default(Text("OK"))
    )
    
    static let loginFailed = AlertItem(
      "Login Failed",
      "We couldn't find an account matching that email and password. Please check your details and try again.",
      dismissButton: .default(Text("OK"))
    )
    
    static let logoutFailed = AlertItem(
      "Logout Error",
      "An error occurred while trying to log you out. Please try again or contact support if the problem persists.",
      dismissButton: .default(Text("OK"))
    )
    
    static let passwordResetLinkSent = AlertItem(
      "Reset Link Sent",
      "A password reset link has been sent to your email. Please check your inbox and spam folder.",
      dismissButton: .default(Text("OK"))
    )
  }
  
  // MARK: - Profile Editing
  
  struct Profile {
    static let updateSuccess = AlertItem(
      "Profile Updated",
      "Your profile information has been successfully updated.",
      dismissButton: .default(Text("OK"))
    )
    
    static let updateFailed = AlertItem(
      "Failed to Update Profile",
      "An error occurred while updating your profile. Please try again later.",
      dismissButton: .default(Text("OK"))
    )
    
    static let emailUpdateFailed = AlertItem(
      "Failed to Update Email",
      "This email address is already in use by another account.",
      dismissButton: .default(Text("OK"))
    )
    
    static let deleteSuccess = AlertItem(
      "Account Deleted",
      "Your account and all associated data have been permanently deleted. We're sorry to see you go.",
      dismissButton: .default(Text("OK"))
    )
    
    static let deleteFailed = AlertItem(
      "Failed to Delete Account",
      "An error occurred while deleting your account. Please contact our support for assistance.",
      dismissButton: .default(Text("OK"))
    )
  }
  
  // MARK: - Coffee Recipe
  
  struct CoffeeRecipe {
    static let deletionSuccess = AlertItem(
      "Recipe deleted",
      "The selected recipe has been successfully deleted.",
      dismissButton: .default(Text("OK"))
    )
    
    static let deletionFailed = AlertItem(
      "Failed to Delete Recipe",
      "An error occurred. Please try again, or contact support if the problem persists.",
      dismissButton: .default(Text("OK"))
    )
  }
  
  // MARK: - General Errors
  
  struct Generic {
    static let unknownError = AlertItem(
      "An Error Occurred",
      "Something went wrong. Please try again later or contact support.",
      dismissButton: .default(Text("OK"))
    )
  }
}
