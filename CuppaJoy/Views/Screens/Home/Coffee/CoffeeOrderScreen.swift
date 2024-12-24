//
//  CoffeeOrderScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct CoffeeOrderScreen: View {
  
  var body: some View {
    ZStack {
      Color.cstDarkBrown.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 25) {
        
        CupCountCell()
        CustomDivider()
        CupSizeCell()
        CustomDivider()
        
        Button {
          // Show the Assembler screen
        } label: {
          Image(systemName: "hand.tap")
            .foregroundStyle(.cstCream)
          HStack(spacing: 5) {
            Text("Customize with")
              .font(.poppins(.regular, size: 15))
              .foregroundStyle(.cstCream)
            Text("Assembler")
              .font(.poppins(.bold, size: 16))
              .foregroundStyle(.cstMint)
          }
        }
        
        Spacer()
        
        VStack(spacing: 15) {
          HStack {
            Text("Total Amount:")
              .font(.poppins(.medium, size: 16))
              .foregroundStyle(.cstCream)
            Spacer()
            Text("₴ \(String(format: "%.2f", 50.00))")
              .font(.poppins(.bold, size: 20))
              .foregroundStyle(.cstWhite)
          }
          CustomDivider()
          CustomBtn("Next") {}
        }
        // If the screen matches the iPhone SE(third generation) screen, then use a 20px bottom padding. If not, then use a 0px padding.
        .padding(.bottom, UIScreen.current?.bounds.height == 667 ? 20 : 0)
      }
      .padding(.horizontal)
    }
  }
}

#Preview {
  CoffeeOrderScreen()
}

// MARK: View Components
private extension CoffeeOrderScreen {
  
  struct CupCountCell: View {
    @State private var count = 0
    
    var body: some View {
      HStack(spacing: 15) {
        Text("Cup count")
        Spacer()
        Button("+") { count += 1 }
        Text("\(count)")
        Button("-") { count -= 1 }
      }
      .foregroundStyle(.cstWhite)
      .font(.poppins(.medium, size: 15))
      .buttonStyle(.bordered)
    }
  }
  
  struct CupSizeCell: View {
    @State private var selectedSize: CoffeeCup = .small
    var body: some View {
      
      VStack(alignment: .leading) {
        Text("Cup size (ml): ")
          .font(.poppins(.medium, size: 15))
          .foregroundStyle(.cstWhite)
        Picker("", selection: $selectedSize) {
          ForEach(CoffeeCup.allCases, id: \.self) { cupSize in
            Text(cupSize.ml)
          }
        }
        .pickerStyle(.segmented)
      }
    }
  }
}


/*
 struct CupSizeCell: View {
   @State private var selectedCup: CoffeeCup = .small
   
   var body: some View {
     HStack {
       Text("Size, ml")
         .font(.poppins(.medium, size: 15))
         .foregroundStyle(.cstWhite)
       
       Spacer()
       
       HStack(alignment: .firstTextBaseline, spacing: 20) {
         ForEach(CoffeeCup.allCases, id: \.self) { cup in
           
           VStack(spacing: 8) {
             Image("coffeeGlass")
               .resizable()
               .frame(width: cup.size, height: cup.size)
             Text(cup.ml)
               .font(.poppins(.medium, size: 14))
           }
           .onTapGesture { selectedCup = cup }
           .foregroundStyle(
             selectedCup == cup ? .cstCream : .cstGray
           )
         }
       }
     }
   }
 }
*/
