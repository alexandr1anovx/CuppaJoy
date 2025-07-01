//
//  LoginViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.06.2025.
//

import Foundation

@MainActor
final class LoginViewModel: ObservableObject {
  
  @Published var email: String = ""
  @Published var password: String = ""
  @Published var alertItem: AlertItem?
  @Published var isShownPasswordRecoveryView: Bool = false
  @Published var isLoading: Bool = false
  
  private let authService: AuthServiceProtocol
  
  var isValidForm: Bool {
    !email.isEmpty && !password.isEmpty
  }
  
  init(authService: AuthServiceProtocol) {
    self.authService = authService
  }
  
  // MARK: - Methods
  
  func signIn() async {
    isLoading = true
    do {
      let _ = try await authService.signIn(
        email: email,
        password: password
      )
    } catch {
      isLoading = false
      alertItem = Alerts.Auth.loginFailed
    }
  }
}
