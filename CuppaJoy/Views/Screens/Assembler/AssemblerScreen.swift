//
//  AssemblageScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 23.10.2024.
//

import SwiftUI

struct AssemblerScreen: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cstBrown.ignoresSafeArea()
                
                VStack {
                    List {
                        // The views are located at the bottom of the file
                        BaristaSelectionView()
                        CoffeeTypeSelectionView()
                        CoffeeSortSelectionView()
                        MilkSelectionView()
                        SyrupSelectionView()
                        AdditivesSelectionView()
                    }
                    .listRowSpacing(20)
                    .listStyle(.plain)
                    
                    TotalAmountView()
                }
                .padding(.top, 10)
            }
            .navigationTitle("Assembler")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    BackButton()
                }
            }
        }
    }
}

#Preview {
    AssemblerScreen()
}

// MARK: - Views
private extension AssemblerScreen {
    
    struct BaristaSelectionView: View {
        var body: some View {
            NavigationLink {
                CoffeeOrderScreen()
            } label: {
                Text("Select a barista")
                    .font(.poppins(.medium, size: 15))
                    .foregroundStyle(.cstWhite)
            }
            .padding(.vertical)
            .listRowBackground(Color.cstBrown)
        }
    }
    
    struct CoffeeTypeSelectionView: View {
        @State private var value: Double = 0.0
        
        var body: some View {
            HStack(spacing: 50) {
                Text("Coffee type")
                    .foregroundStyle(.cstWhite)
                    .font(.poppins(.medium, size: 15))
                VStack {
                    Slider(value: $value, in: 0...1)
                        .tint(.cstMint)
                    HStack {
                        Text("Arabica")
                        Spacer()
                        Text("Robusta")
                    }
                    .foregroundStyle(.cstMint)
                    .font(.poppins(.regular, size: 13))
                }
            }
            .listRowBackground(Color.cstBrown)
        }
    }
    
    struct CoffeeSortSelectionView: View {
        @State private var sort: CoffeeSort = .santos
        
        var body: some View {
            Picker("Coffee sort", selection: $sort) {
                ForEach(CoffeeSort.allCases, id: \.self) { sort in
                    Text(sort.rawValue)
                }
            }
            .pickerStyle(.menu)
            .font(.poppins(.medium, size: 15))
            .foregroundStyle(.cstWhite)
            .tint(.cstMint)
            .listRowBackground(Color.cstBrown)
        }
    }
    
    struct MilkSelectionView: View {
        @State private var milk: Milk = .none
        
        var body: some View {
            Picker("Milk", selection: $milk) {
                ForEach(Milk.allCases, id: \.self) { milk in
                    Text(milk.rawValue)
                }
            }
            .pickerStyle(.menu)
            .font(.poppins(.medium, size: 15))
            .foregroundStyle(.cstWhite)
            .tint(.cstMint)
            .listRowBackground(Color.cstBrown)
        }
    }
    
    struct SyrupSelectionView: View {
        @State private var syrup: Syrup = .none
        
        var body: some View {
            Picker("Syrup", selection: $syrup) {
                ForEach(Syrup.allCases, id: \.self) { syrup in
                    Text(syrup.rawValue)
                }
            }
            .pickerStyle(.menu)
            .font(.poppins(.medium, size: 15))
            .foregroundStyle(.cstWhite)
            .tint(.cstMint)
            .listRowBackground(Color.cstBrown)
        }
    }
    
    struct AdditivesSelectionView: View {
        @State private var additive: Additive = .none
        
        var body: some View {
            Picker("Additives", selection: $additive) {
                ForEach(Additive.allCases, id: \.self) { additive in
                    Text(additive.rawValue)
                        .foregroundStyle(.cstMint)
                }
            }
            .pickerStyle(.navigationLink)
            .font(.poppins(.medium, size: 15))
            .foregroundStyle(.cstWhite)
            .listRowBackground(Color.cstBrown)
        }
    }
}

// MARK: - Enums
private extension AssemblerScreen {
    
    enum CoffeeSort: String, CaseIterable {
        case santos = "Santos"
        case bourbonSantos = "Bourbon Santos"
        case minas = "Minas"
        case rio = "Rio"
        case canilon = "Canilon"
        case flatBeat = "Flat Beat"
    }
    
    enum Milk: String, CaseIterable {
        case none = "None"
        case cows = "Cow's"
        case lactose = "Lactose-free"
        case skimmed = "Skimmed"
        case vegetable = "Vegetable"
    }
    
    enum Syrup: String, CaseIterable {
        case none = "None"
        case amaretto = "Amaretto"
        case coconut = "Coconut"
        case vanilla = "Vanilla"
        case caramel = "Caramel"
    }
    
    enum Additive: String, CaseIterable {
        case none = "None"
        case ceylonCinnamon = "Ceylon cinnamon"
        case gratedChocolate = "Grated chocolate"
        case liquidChocolate = "Liquid chocolate"
        case marshmallow = "Marshmallow"
        case cream = "Cream"
        case iceCream = "Ice cream"
    }
}
