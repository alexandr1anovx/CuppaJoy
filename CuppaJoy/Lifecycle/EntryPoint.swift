//
//  TabBar.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

/*
 HOME:
 
 1) Home Screen -> QRCode Screen.
 2) Home Screen -> Profile Screen.
 3) Home Screen -> OrderOptionsScreen -> 
*/

struct EntryPoint: View {
  
  var body: some View {
    NavigationStack {
      TabView {
        HomeScreen()
          .tabItem {
            Image("house")
            Text("Home")
          }
        RewardsScreen()
          .tabItem {
            Image("gift")
            Text("Rewards")
          }
        OrderTabScreen()
          .tabItem {
            Image("bill")
            Text("History")
          }
      }
    }
  }
}

#Preview {
  EntryPoint()
}
