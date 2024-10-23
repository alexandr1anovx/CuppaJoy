//
//  CoffeeOrderScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct CoffeeOrderScreen: View {
    
    // MARK: - Properties
    @State private var coffeeCount = 0
    @State private var selectedCup: CoffeeCup = .small
    @State private var isShownTime = false
    @State private var currentTime = Date.now
    
    var body: some View {
        ZStack {
            Color.primarySystem.ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                // MARK: - Coffee Image
                Image("coffeeGlass")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(.primaryMint)
                
                // MARK: - Coffee Quantity
                HStack {
                    Text("Cappuccino")
                    Spacer()
                    Button("+") { coffeeCount += 1 }
                    Text("\(coffeeCount)")
                    Button("-") { coffeeCount -= 1 }
                }
                .foregroundStyle(.primaryMint)
                .font(.poppins(.medium, size: 15))
                .buttonStyle(.bordered)
                
                Divider()
                
                // MARK: - Coffee cup size
                HStack {
                    Text("Cup size, ml")
                        .font(.poppins(.medium, size: 15))
                        .foregroundStyle(.primaryMint)
                    
                    Spacer()
                    
                    HStack(alignment: .firstTextBaseline, spacing: 15) {
                        ForEach(CoffeeCup.allCases, id: \.self) { cup in
                            VStack(spacing: 5) {
                                Image("coffeeGlass")
                                    .resizable()
                                    .frame(width: cup.size, height: cup.size)
                                Text(cup.ml)
                                    .font(.poppins(.regular, size: 14))
                            }
                            .onTapGesture { selectedCup = cup }
                            .foregroundStyle(
                                selectedCup == cup ? .primaryBrown : .primaryMint
                            )
                        }
                    }
                }
                
                Divider()
                
                // MARK: - Time-based delivery
                HStack {
                    VStack(spacing: 20) {
                        Toggle("Specific delivery time", isOn: $isShownTime)
                            .tint(.primaryMint)
                            .font(.poppins(.medium, size: 15))
                            .foregroundStyle(.primaryMint)
                        
                        if isShownTime {
                            DatePicker(
                                "",
                                selection: $currentTime,
                                displayedComponents: .hourAndMinute
                            )
                        }
                    }
                }
                
                // MARK: - Coffee assemblage
                Button {
                    // Redirect to assemblage screen
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "checklist.unchecked")
                        Text("Coffee assemblage")
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .foregroundStyle(.primaryGreen)
                    .padding()
                    .background(.primaryMint)
                    .clipShape(.buttonBorder)
                }
                
                Spacer()
                
                // MARK: - Total Amount and Next button
                VStack(spacing: 30) {
                    HStack {
                        Text("Total amount")
                            .font(.poppins(.medium, size: 16))
                        Spacer()
                        Text("UAH 50.00")
                            .font(.poppins(.bold, size: 18))
                    }
                    
                    Button("Next") {
                        
                    }
                    .padding(.vertical)
                    .padding(.horizontal, 80)
                    .background(.primaryMint)
                    .foregroundStyle(.primaryGreen)
                    .clipShape(.buttonBorder)
                }
            }
            .padding(.top)
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

#if DEBUG
#Preview {
    CoffeeOrderScreen()
}
#endif
