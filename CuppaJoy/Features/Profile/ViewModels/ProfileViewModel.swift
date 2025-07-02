//
//  ProfileViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.07.2025.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
  
  @Published var fullName: String = ""
  @Published var email: String = ""
  @Published var deletionPassword: String = ""
  @Published var selectedCity: City = .mykolaiv
  @Published var isShownDeleteAccountAlert: Bool = false
  @Published var isShownSavedChangesAlert: Bool = false
  @Published var alert: AlertItem?
  
  // MARK: - Computed Properties
  
  var formHasChanges: Bool {
    guard let user = sessionManager.currentUser else { return false }
    let changedName = fullName != user.fullName
    let changedEmail = email != user.email
    let changedCity = selectedCity.rawValue != user.city
    return changedName || changedEmail || changedCity
  }
  
  var isValidForm: Bool {
    ValidationService.isValid(fullName: fullName) &&
    (email == sessionManager.currentUser?.email || ValidationService.isValid(email: email))
  }
  
  // MARK: - Private Properties
  
  private let sessionManager: SessionManager
  private let authService: AuthServiceProtocol
  private let userService: UserServiceProtocol
  
  // MARK: - Init
  
  init(
    sessionManager: SessionManager,
    authService: AuthServiceProtocol,
    userService: UserServiceProtocol
  ) {
    self.sessionManager = sessionManager
    self.authService = authService
    self.userService = userService
  }
  
  // MARK: - Public Methods
  
  func saveChanges() async {
    guard var user = sessionManager.currentUser else { return }
    user.fullName = fullName
    user.email = email
    user.city = selectedCity.rawValue
    do {
      try await userService.createOrUpdateAppUser(user: user)
      sessionManager.currentUser = user
      alert = Alerts.Profile.updateSuccess
    } catch {
      alert = Alerts.Profile.updateFailed
    }
  }
  
  func deleteAccount() async {
    do {
      try await userService.deleteUserDocument(withPassword: deletionPassword)
      try await authService.deleteAccount()
      alert = Alerts.Profile.deleteSuccess
    } catch {
      alert = Alerts.Profile.deleteFailed
    }
  }
  
  func signOut() {
    do {
      try authService.signOut()
    } catch {
      alert = Alerts.Auth.logoutFailed
    }
  }
  
  func loadUserData() {
    guard let user = sessionManager.currentUser else { return }
    fullName = user.fullName
    email = user.email
    selectedCity = City(rawValue: user.city)!
  }
}
