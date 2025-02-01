//
//  UIApplication+Extension.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 01.02.2025.
//

import UIKit

// Hides the keyboard when the user taps on any part of the screen.

extension UIApplication {
  
  func hideKeyboard() {
    let responder = #selector(UIResponder.resignFirstResponder)
    UIApplication.shared.sendAction(responder, to: nil, from: nil, for: nil)
  }
}
