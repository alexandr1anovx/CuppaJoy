//
//  GreetingScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct GreetingScreen: View {
    var body: some View {
        ZStack {
            Color.cream.ignoresSafeArea()
            VStack {
                TopBlock()
                    .padding(.top, 10)
                DescriptionView()
                    .padding(.top, 40)
                PagesIndicator()
                
                Spacer()
                NextButton()
                    .padding(.bottom, 20)
                    .padding(.horizontal)
            }
        }
    }
}

#Preview {
    GreetingScreen()
}

struct TopBlock: View {
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 30)
                .fill(.beige)
                .frame(
                    width: geometry.size.width - 40,
                    height: 260,
                    alignment: .center
                )
                .shadow(radius: 10)
                .padding(.horizontal, 20)
                .overlay {
                    Image(.logo)
                        .resizable()
                        .frame(width: 300, height: 320)
                }
        }
        
    }
}

struct DescriptionView: View {
    var body: some View {
        VStack(spacing: 3) {
            Text("Feel yourself like a barista!")
                .font(.custom("Poppins", size: 35))
                .fontWeight(.regular)
                
                .foregroundStyle(.middleBrown)
                .multilineTextAlignment(.center)
            
            Text("Magic coffee on order.")
                .font(.custom("Poppins", size: 20))
                .fontWeight(.regular)
                .foregroundStyle(.hotGray)
        }
    }
}

struct PagesIndicator: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 50)
                .frame(width: 30, height: 10)
                .foregroundStyle(.darkBrown)
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

struct NextButton: View {
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                // action
            } label: {
                Circle()
                    .fill(.middleBrown)
                    .frame(
                        width: 64,
                        height: 64,
                        alignment: .center
                    )
                    .shadow(radius: 8)
                    .overlay {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 18, height: 15)
                            .foregroundStyle(.white)
                    }
            }
        }
    }
}
