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
  let authAction: AuthAction
  
  init(for authAction: AuthAction) {
    self.authAction = authAction
  }
  
  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      Text(authAction.title)
        .font(.title2)
        .fontWeight(.bold)
        .foregroundStyle(.white)
      Text(authAction.subtitle)
        .font(.title3)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
    }
  }
}

#Preview {
  AuthHeaderView(for: .signIn)
}
