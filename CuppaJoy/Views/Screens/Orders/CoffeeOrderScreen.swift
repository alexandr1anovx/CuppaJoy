//
//  CoffeeOrderScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct CoffeeOrderScreen: View {
    
    @State private var glassCount = 0
    @State private var selectedCup: CoffeeCup = .small
    @State private var isShownTime = false
    @State private var currentTime = Date.now
    
    var body: some View {
        ZStack {
            Color.cstDarkBrown.ignoresSafeArea()
            
            VStack(spacing: 23) {
                
                Image("coffeeCup")
                    .resizable()
                    .frame(width: 180, height: 160)
                    .foregroundStyle(.cstMint)
                
                HStack(spacing: 15) {
                    Text("Cappuccino")
                    Spacer()
                    Button("+") { glassCount += 1 }
                    Text("\(glassCount)")
                    Button("-") { glassCount -= 1 }
                }
                .foregroundStyle(.cstCream)
                .font(.poppins(.medium, size: 15))
                .buttonStyle(.bordered)
                
                CustomDivider()
                
                HStack {
                    Text("Cup size, ml")
                        .font(.poppins(.medium, size: 15))
                        .foregroundStyle(.cstCream)
                    
                    Spacer()
                    
                    HStack(alignment: .firstTextBaseline, spacing: 15) {
                        ForEach(CoffeeCup.allCases, id: \.self) { cup in
                            VStack(spacing: 5) {
                                Image("coffeeGlass")
                                    .resizable()
                                    .frame(width: cup.size, height: cup.size)
                                Text(cup.ml)
                                    .font(.poppins(.regular, size: 15))
                            }
                            .onTapGesture { selectedCup = cup }
                            .foregroundStyle(
                                selectedCup == cup ? .cstCream : .cstGray
                            )
                        }
                    }
                }
                
                CustomDivider()
                
                HStack {
                    VStack(spacing: 20) {
                        Toggle("Specific delivery time", isOn: $isShownTime)
                            .font(.poppins(.medium, size: 15))
                            .foregroundStyle(.cstCream)
                            .tint(.cstCream)
                        
                        if isShownTime {
                            DatePicker("", selection: $currentTime, displayedComponents: .hourAndMinute
                            )
                        }
                    }
                }
                HStack {
                    MainButton("Assembler") {
                        // Redirect to assemblage screen
                    }
                    
                    Spacer()
                }
                
                Spacer()
                
                VStack(spacing: 20) {
                    HStack {
                        Text("Total amount")
                            .font(.poppins(.medium, size: 17))
                        Spacer()
                        Text("UAH 50.00")
                            .font(.poppins(.medium, size: 20))
                    }
                    .foregroundStyle(.cstCream)
                    
                    CustomDivider()
                    
                    MainButton("Next") {
                        
                    }
                    
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 30)
        }
    }
}

enum CoffeeCup: Int, CaseIterable {
    case small, medium, large
    
    var ml: String {
        switch self {
        case .small: "250"
        case .medium: "350"
        case .large: "450"
        }
    }
    
    var size: CGFloat {
        switch self {
        case .small: 30
        case .medium: 35
        case .large: 40
        }
    }
    
    var price: Double {
        switch self {
        case .small: 30.50
        case .medium: 32.50
        case .large: 35.50
        }
    }
}

#Preview { CoffeeOrderScreen() }
