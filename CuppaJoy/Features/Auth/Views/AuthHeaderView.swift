//
//  AuthHeaderView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 10.01.2025.
//

import SwiftUI

enum AuthAction {
  case signIn, signUp
  
  var title: String {
    switch self {
    case .signIn: "Sign in."
    case .signUp: "Sign up."
    }
  }
  var subtitle: String {
    switch self {
    case .signIn: "Select a convenient way."
    case .signUp: "Create a new account."
    }
  }
}

struct AuthHeaderView: View {
  private let authAction: AuthAction
  
  init(for authAction: AuthAction) {
    self.authAction = authAction
  }
  
  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      Text(authAction.title)
        .font(.title3)
        .fontWeight(.bold)
        .foregroundStyle(.csCream)
      Text(authAction.subtitle)
        .font(.headline)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
    }
  }
}

#Preview {
  AuthHeaderView(for: .signIn)
}
