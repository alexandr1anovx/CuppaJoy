//
//  SessionManager.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.06.2025.
//

import Foundation
import FirebaseAuth

enum SessionState: Equatable {
  case signedIn(FirebaseAuth.User)
  case signedOut
}

final class SessionManager: ObservableObject {
  @Published var sessionState: SessionState = .signedOut
  @Published var currentUser: User? = nil
  
  private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
  private let userService: UserServiceProtocol
  
  init(userService: UserServiceProtocol) {
    self.userService = userService
    
    authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
      guard let self = self else { return }
      if let user {
        Task { @MainActor in
        self.sessionState = .signedIn(user)
        
          do {
            self.currentUser = try await self.userService.fetchAppUser(uid: user.uid)
          } catch {
            self.currentUser = nil
          }
        }
      } else {
        self.sessionState = .signedOut
        self.currentUser = nil
      }
    }
  }
  
  deinit {
    if let handle = authStateListenerHandle {
      Auth.auth().removeStateDidChangeListener(handle)
    }
  }
}
