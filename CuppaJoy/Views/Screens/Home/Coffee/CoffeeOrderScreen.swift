//
//  CoffeeOrderScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct CoffeeOrderScreen: View {
  let selectedCoffee: Coffee
  
  var body: some View {
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
        CustomDivider()
        CupSizeCell()
        CustomDivider()
        
        Button {
          // show the Assembler screen
        } label: {
          Image(systemName: "cup.and.heat.waves.fill")
            .foregroundStyle(.cstCream)
          HStack(spacing: 5) {
            Text("Customize with")
              .font(.poppins(.medium, size: 14))
              .foregroundStyle(.cstCream)
            Text("Assembler")
              .font(.poppins(.bold, size: 15))
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
        /*
         Use a 20px padding for iPhone SE 3rd.
         Use a 0px padding for others iPhones.
        */
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

#Preview {
  CoffeeOrderScreen(selectedCoffee: .espresso)
}

// MARK: View Components
private extension CoffeeOrderScreen {
  
  struct CupCountCell: View {
    @State private var count = 0
    
    var body: some View {
      HStack(spacing: 15) {
        Text("Cup count")
        Spacer()
        Button("-") { count -= 1 }
        Text("\(count)")
        Button("+") { count += 1 }
      }
      .foregroundStyle(.cstCream)
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
          .foregroundStyle(.cstCream)
        Picker("", selection: $selectedSize) {
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
