//
//  ProfileScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.10.2024.
//

import SwiftUI

struct ProfileScreen: View {
    var body: some View {
        NavigationStack { // Remove the NavigationStack in the future!
            ZStack {
                Color.primarySystem.ignoresSafeArea(.all)
                
                VStack(spacing: 30) {
                    UserDataCell(
                        image: "person",
                        header: "Name",
                        content: "Alex"
                    )
                    UserDataCell(
                        image: "phone",
                        header: "Phone number",
                        content: "+375 33 664-57-36"
                    )
                    UserDataCell(
                        image: "envelope",
                        header: "Email",
                        content: "testEmail@gmail.com"
                    )
                    UserDataCell(
                        image: "mappin.and.ellipse",
                        header: "Magic Coffee store address",
                        content: "Bradford BD1 1PR"
                    )
                    Image(systemName: "qrcode")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .padding(.vertical, 100)
                    
                    Spacer()
                }
                .padding(.top, 30)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ProfileScreen()
}
