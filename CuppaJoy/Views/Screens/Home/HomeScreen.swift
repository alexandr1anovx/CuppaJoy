//
//  HomeScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.10.2024.
//

import SwiftUI

struct HomeScreen: View {
    @Binding var isShownTabBar: Bool
    
    var body: some View {
        ZStack {
            Color.cstBrown.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 25) {
                HomeHeader()
                CoffeeSelectionView()
            }
        }
    }
}

#Preview {
    HomeScreen(isShownTabBar: .constant(true))
}


struct HomeHeader: View {
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 15) {
                Text("Alexander")
                    .font(.poppins(.medium, size: 18))
                    .foregroundStyle(.cstMint)
                Text("+380(67)-936-75-89")
                    .font(.poppins(.regular, size: 14))
                    .foregroundStyle(.cstWhite)
                
                HStack {
                    Image("mappin")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .foregroundStyle(.cstMint)
                    Text("Bradford BD1 1PR")
                        .font(.poppins(.medium, size: 14))
                        .foregroundStyle(.cstWhite)
                }
            }
            
            Spacer()
            
            Image("bag")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundStyle(.cstMint)
            Image("user")
                .resizable()
                .frame(width: 28, height: 28)
                .foregroundStyle(.cstMint)
        }
        .padding(.horizontal, 25)
        .padding(.top)
    }
}
