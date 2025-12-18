//
//  RegistrationViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.06.2025.
//

import SwiftUI

@MainActor
@Observable
final class RegistrationViewModel {
  
  var fullName = ""
  var email = ""
  var password = ""
  var confirmedPassword = ""
  var selectedCity: City = .mykolaiv
  var isLoading = false
  var alert: AlertItem?
  
  var isValidForm: Bool {
    ValidationService.isValid(fullName: fullName)
    && ValidationService.isValid(email: email)
    && password.count > 5 && password == confirmedPassword
  }
  
  private let authService: AuthServiceProtocol
  private let userService: UserServiceProtocol
  
  init(authService: AuthServiceProtocol, userService: UserServiceProtocol) {
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
      isLoading = false
    } catch {
      isLoading = false
      alert = Alerts.Auth.registrationFailed
    }
  }
}

extension RegistrationViewModel {
  static var previewMode: RegistrationViewModel {
    let authService = AuthService()
    let userService = UserService()
    let viewModel = RegistrationViewModel(
      authService: authService,
      userService: userService
    )
    viewModel.fullName = "John Doe"
    viewModel.email = "johndoe@example.com"
    viewModel.password = "123456"
    viewModel.confirmedPassword = "123456"
    return viewModel
  }
}
