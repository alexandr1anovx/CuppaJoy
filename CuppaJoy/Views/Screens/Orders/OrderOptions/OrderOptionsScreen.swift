//
//  CoffeeOrderScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct OrderOptionsScreen: View {
  let selectedCoffee: Coffee
  
  var body: some View {
    
    // The views for this screen are located at the bottom of the file.
    
    ZStack {
      Color.cstDarkBrown.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 25) {
        HStack {
          Spacer()
          Image(systemName: "cup.and.saucer.fill")
            .resizable()
            .scaledToFit()
            .frame(maxHeight: 70)
            .foregroundStyle(.cstCream)
          Spacer()
        }
        
        CupCountCell()
        CustomSeparator()
        CupSizeCell()
        CustomSeparator()
        
        NavigationLink {
          AssemblerScreen()
        } label: {
          HStack(spacing: 4) {
            Label("Customize with", systemImage: "cup.and.heat.waves.fill")
              .foregroundStyle(.cstCream)
              .font(.poppins(.medium, size: 14))
            Text("Assembler")
              .font(.poppins(.bold, size: 15))
              .foregroundStyle(.cstMint)
          }
        }
        
        Spacer()
        
        VStack(spacing: 20) {
          HStack {
            Text("Total Amount:")
              .font(.poppins(.medium, size: 15))
              .foregroundStyle(.cstCream)
            Spacer()
            Text("₴ \(String(format: "%.2f", 50.00))")
              .font(.poppins(.bold, size: 18))
              .foregroundStyle(.cstWhite)
          }
          CustomSeparator()
          CustomBtn("Make an order") {
            // action
          }
        }
        // 20px bottom padding for iPhone SE 3rd generation.
        // 0px bottom padding for others iPhones.
        .padding(.bottom, UIScreen.current?.bounds.height == 667 ? 20 : 0)
      }
      .padding(.horizontal, 20)
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          ArrowBackBtn()
        }
      }
    }
  }
}

private extension OrderOptionsScreen {
  
  struct CupCountCell: View {
    @State private var cupCount: Int = 1
    
    var body: some View {
      HStack {
        Text("Cup count")
        
        Spacer()
        
        Button("-") {
          withAnimation { cupCount -= 1 }
        }
        .tint(.cstBrown)
        .disabled(cupCount == 0)
        .buttonStyle(.bordered)
        
        Text("\(cupCount)")
          .frame(minWidth: 20)
          .contentTransition(.numericText(value: Double(cupCount)))
        
        Button("+") {
          withAnimation { cupCount += 1 }
        }
        .tint(.cstBrown)
        .disabled(cupCount == 5)
        .buttonStyle(.bordered)
      }
      .font(.poppins(.medium, size: 15))
      .foregroundStyle(.cstCream)
    }
  }
  
  struct CupSizeCell: View {
    @State private var selectedCupSize: CoffeeCup = .small
    
    var body: some View {
      VStack(alignment: .leading) {
        Text("Cup size (ml):")
          .font(.poppins(.medium, size: 15))
          .foregroundStyle(.cstCream)
        Picker("", selection: $selectedCupSize) {
          ForEach(CoffeeCup.allCases, id: \.self) { cupSize in
            Text(cupSize.ml)
          }
        }
        .pickerStyle(.segmented)
        .colorMultiply(.cstCream)
      }
    }
  }
}

#Preview {
  OrderOptionsScreen(selectedCoffee: .espresso)
}
