//
//  RegistrationViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.06.2025.
//

import Foundation

@MainActor
final class RegistrationViewModel: ObservableObject {
  
  // MARK: - Public Properties
  
  @Published var fullName: String = ""
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var confirmedPassword: String = ""
  @Published var selectedCity: City = .mykolaiv
  
  @Published var alertItem: AlertItem?
  @Published var isLoading: Bool = false
  
  // MARK: - Private Properties
  
  private let authService: AuthServiceProtocol
  private let userService: UserServiceProtocol
  
  // MARK: - Computed Properties
  
  var isValidForm: Bool {
    ValidationService.isValid(fullName: fullName)
    && ValidationService.isValid(email: email)
    && password.count > 5
    //&& password == confirmedPassword
  }
  
  // MARK: - Init
  
  init(
    authService: AuthServiceProtocol,
    userService: UserServiceProtocol
  ) {
    self.authService = authService
    self.userService = userService
  }
  
  // MARK: - Methods
  
  func signUp() async {
    isLoading = true
    
    do {
      let user = try await authService.signUp(
        email: email,
        password: password
      )
      let appUser = User(
        uid: user.uid,
        fullName: fullName,
        email: email,
        city: selectedCity.rawValue,
        coins: Int.random(in: 0...5)
      )
      try await userService.createOrUpdateAppUser(user: appUser)
      print("✅ RegistrationViewModel: Successfully signed up!")
      isLoading = false
    } catch {
      isLoading = false
      alertItem = Alerts.Auth.registrationFailed
      print("⚠️ RegistrationViewModel: Failed to sign up: \(error.localizedDescription)")
    }
  }
}

