//
//  SignInScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct SignInScreen: View {
    
    @State private var username = ""
    
    var body: some View {
        ZStack {
            Color.cream.ignoresSafeArea()
            
            // MARK: - Main
            VStack {
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Sign In")
                            .font(.custom("Poppins", size: 22))
                            .fontWeight(.medium)
                            .foregroundStyle(.darkBrown)
                            
                        Text("Welcome back")
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.regular)
                            .foregroundStyle(.hotGray)
                    }
                    
                    Spacer()
                }
                .padding(.leading, 40)
                
                VStack(spacing: 8) {
                    HStack {
                        Image(systemName: "envelope")
                            .font(.callout)
                        Rectangle()
                            .fill(.hotGray)
                            .frame(width: 0.5, height: 20)
                        
                        TextField("Email address", text: $username)
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.medium)
                        
                    }
                    Rectangle()
                        .fill(Color.hotGray)
                        .frame(width: .infinity, height: 0.5)
                    
                    HStack {
                        Image(systemName: "envelope")
                            .font(.callout)
                        Rectangle()
                            .fill(.hotGray)
                            .frame(width: 0.5, height: 20)
                        
                        TextField("Email address", text: $username)
                            .font(.custom("Poppins", size: 14))
                            .fontWeight(.medium)
                        
                    }
                    Rectangle()
                        .fill(Color.hotGray)
                        .frame(width: .infinity, height: 0.5)
                }
                .padding(.horizontal, 40)
                .padding(.top)
                
                
                
                
                
                
                
                
            }
        }
    }
}

#Preview {
    SignInScreen()
}
