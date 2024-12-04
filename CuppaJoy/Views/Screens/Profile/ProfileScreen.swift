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
                Color.cstDarkBrown.ignoresSafeArea(.all)
                
                VStack(spacing: 30) {
                    ProfileContentCell(
                        image: "user",
                        header: "Name",
                        content: "Alexander"
                    )
                    ProfileContentCell(
                        image: "smartphone",
                        header: "Phone number",
                        content: "+380955302040"
                    )
                    ProfileContentCell(
                        image: "mailbox",
                        header: "Email",
                        content: "myEmail@gmail.com"
                    )
                    ProfileContentCell(
                        image: "mappin",
                        header: "Magic Coffee store address",
                        content: "3-rd Slobidska"
                    )
                    
                    Spacer()
                    Image(systemName: "qrcode.viewfinder")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .foregroundStyle(.cstGray)
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
