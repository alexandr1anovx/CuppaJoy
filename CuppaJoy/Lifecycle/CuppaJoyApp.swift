//
//  CuppaJoyApp.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

@main
struct CuppaJoyApp: App {
  var body: some Scene {
    WindowGroup {
      CustomTabView()
        .preferredColorScheme(.dark)
    }
  }
}
