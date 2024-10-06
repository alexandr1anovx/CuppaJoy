//
//  GreetingScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct GreetingScreen: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cream.ignoresSafeArea()
                
                VStack {
                    LogoBlock()
                        .padding(.top, 20)
                    DescriptionView()
                        .padding(.top, 40)
                    PagesIndicator()
                    
                    Spacer()
                    
                    NavigationLink {
                        SignInScreen()
                    } label: {
                        Spacer()
                        NextStepView()
                    }
                    .padding(20)
                }
            }
        }
    }
}

#Preview {
    GreetingScreen()
}

struct LogoBlock: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(.golden)
            .frame(height: 270, alignment: .center)
            .rotation3DEffect(
                .degrees(5),
                axis: (x: 5.0, y: 5.0, z: 0.0)
            )
            .padding(.horizontal, 40)
            .shadow(radius: 15)
            .overlay {
                Image(.logo)
                    .resizable()
                    .frame(width: 300, height: 320)
            }
    }
}

struct DescriptionView: View {
    var body: some View {
        VStack {
            Text("Feel yourself like a barista!")
                .font(.poppins(.regular, size: 30))
                .foregroundStyle(.middleBrown)
                .multilineTextAlignment(.center)
            
            Text("Magic coffee on order.")
                .font(.poppins(.regular, size: 15))
                .foregroundStyle(.hotGray)
        }
    }
}

struct PagesIndicator: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 30, height: 10)
                .foregroundStyle(.middleBrown)
            Circle()
                .foregroundStyle(.hotGray)
                .opacity(0.3)
                .frame(width: 10, height: 10)
            
            Circle()
                .foregroundStyle(.hotGray)
                .opacity(0.3)
                .frame(width: 10, height: 10)
            
        }
        .foregroundStyle(.darkBrown)
        .padding(.top, 20)
    }
}

struct NextStepView: View {
    var body: some View {
        Circle()
            .fill(.middleBrown)
            .frame(width: 64, height: 64)
            .shadow(radius: 10)
            .overlay {
                Image(systemName: "arrow.right")
                    .font(.title3)
                    .foregroundStyle(.white)
            }
    }
}
