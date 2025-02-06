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
      Color.appBackground.ignoresSafeArea(.all)
      VStack {
        List {
          QuantityCell()
          CupSizeCell()
          CoffeeTypePicker()
          MilkPicker()
          SyrupPicker()
          AdditivePicker()
          IceCubePicker()
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(20)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .shadow(radius: 8)
        
        HStack {
          VStack(alignment: .center, spacing: 8) {
            Text("Total Price:")
              .font(.subheadline)
              .fontDesign(.monospaced)
              .foregroundStyle(.gray)
            Text("₴ 35.00")
              .font(.title2).bold()
              .foregroundStyle(.white)
          }
          Spacer()
          NavigationLink {
            PendingOrderScreen()
          } label: {
            Text("Confirm")
              .font(.callout).bold()
              .fontDesign(.monospaced)
              .foregroundStyle(.accent)
              .padding(16)
              .background(.black)
              .clipShape(.buttonBorder)
          }
        }
        .shadow(radius: 8)
        .padding(20)
        
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
