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
  @Published var alert: AlertItem?
  @Published var isShownPasswordRecoveryView: Bool = false
  @Published var isLoading: Bool = false
  
  var isValidForm: Bool {
    !email.isEmpty && !password.isEmpty
  }
  
  private let authService: AuthServiceProtocol
  
  init(authService: AuthServiceProtocol) {
    self.authService = authService
  }
  
  // MARK: - Public Methods
  
  func signIn() async {
    isLoading = true
    do {
      let _ = try await authService.signIn(email: email, password: password)
    } catch {
      isLoading = false
      alert = Alerts.Auth.loginFailed
    }
  }
}

extension LoginViewModel {
  static var previewMode: LoginViewModel {
    let authService = AuthService()
    let viewModel = LoginViewModel(authService: authService)
    viewModel.email = "johndoe@example.com"
    viewModel.password = "123456"
    return viewModel
  }
}
