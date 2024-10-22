//
//  HomeScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.10.2024.
//

import SwiftUI
import MapKit

struct HomeScreen: View {
    @Binding var isShownTabBar: Bool
    
    var body: some View {
        Map {
            
        }
        
    }
}

#Preview {
    HomeScreen(
        isShownTabBar: .constant(true)
    )
}
