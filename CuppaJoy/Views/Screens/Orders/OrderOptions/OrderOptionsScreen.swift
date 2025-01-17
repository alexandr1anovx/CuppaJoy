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
    ZStack {
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      VStack {
        
        List {
          QuantityCell()
          CupSizeCell()
          CoffeeTypePicker()
          SortPicker()
          MilkPicker()
          SyrupPicker()
          AdditivePicker()
          IceCubePicker()
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(18)
        .scrollContentBackground(.hidden)
        
        VStack(spacing: 15) {
          HStack {
            Text("Total Price:")
              .font(.poppins(.medium, size: 14))
              .foregroundStyle(.gray)
            Spacer()
            Text("₴ \(String(format: "%.2f", 50.00))")
              .font(.poppins(.bold, size: 16))
              .foregroundStyle(.white)
          }
          .padding(.top, 8)
          
          CustomSeparator()
          
          NavigationLink {
            PendingOrderScreen()
          } label: {
            Text("Make an order")
              .frame(minWidth: 50)
              .font(.poppins(.medium, size: 14))
              .foregroundStyle(.white)
              .padding(15)
              .background(.black)
              .clipShape(.buttonBorder)
              .shadow(radius: 8)
          }
        }
        .padding(.horizontal, 25)
        // 20px bottom padding for iPhone SE 3rd generation.
        .padding(.bottom, UIScreen.current?.bounds.height == 667 ? 20 : 0)
      }
      .navigationTitle("Order Options")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          ReturnButton()
        }
      }
    }
  }
}

#Preview {
  OrderOptionsScreen(selectedCoffee: .espresso)
}
