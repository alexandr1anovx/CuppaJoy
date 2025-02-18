//
//  AuthHeaderView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 10.01.2025.
//

import SwiftUI

enum AuthAction {
  case signIn
  case signUp
  
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
  
  var body: some View {
    HStack(alignment: .firstTextBaseline) {
      Text(authAction.title)
        .font(.title2)
        .fontWeight(.bold)
        .foregroundStyle(.white)
      Text(authAction.subtitle)
        .font(.title3)
        .foregroundStyle(.gray)
    }
  }
}

#Preview {
  AuthHeaderView(authAction: .signIn)
}
