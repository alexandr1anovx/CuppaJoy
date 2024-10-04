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
        RoundedRectangle(cornerRadius: 30)
            .fill(.beige)
            .frame(
                width: .infinity - 40,
                height: 260,
                alignment: .center
            )
            .padding(.horizontal, 20)
            .overlay {
                Image(.logo)
                    .resizable()
                    .frame(width: 310, height: 330)
            }
    }
}

struct DescriptionView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Feel yourself like a barista!")
                .font(.custom("Avenir", size: 37))
                .foregroundStyle(.middleBrown)
                .multilineTextAlignment(.center)
            
            Text("Magic coffee on order.")
                .font(.custom("Avenir", size: 21))
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
                print("Next button pressed")
            } label: {
                Circle()
                    .fill(.middleBrown)
                    .frame(
                        width: 64,
                        height: 64,
                        alignment: .center
                    )
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
