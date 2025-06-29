//
//  SessionManager.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.06.2025.
//

import Foundation
import FirebaseAuth

enum SessionState {
  case signedIn(User)
  case signedOut
}

@MainActor
final class SessionManager: ObservableObject {
  
  @Published var sessionState: SessionState = .signedOut
  @Published var currentUser: AppUser? = nil
  
  private var authStateListenerHandle: AuthStateDidChangeListenerHandle?
  private let firestoreUserService: UserServiceProtocol
  
  init(firestoreUserService: UserServiceProtocol) {
    self.firestoreUserService = firestoreUserService
    
    authStateListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
      guard let self = self else { return }
      if let firestoreUser = user {
        self.sessionState = .signedIn(firestoreUser)
        Task {
          do {
            self.currentUser = try await self.firestoreUserService.fetchAppUser(uid: firestoreUser.uid)
            print("✅ SessionManager: Fetched current user successfully!")
          } catch {
            print("⚠️ SessionManager: Error fetching current user: \(error.localizedDescription)")
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
