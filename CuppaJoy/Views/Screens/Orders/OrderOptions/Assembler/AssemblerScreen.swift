//
//  AssemblageScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 23.10.2024.
//

import SwiftUI

struct AssemblerScreen: View {
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack {
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      VStack {
        List {
          CoffeeTypePicker()
          SortPicker()
          MilkPicker()
          SyrupPicker()
          AdditivePicker()
          IceCubePicker()
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(20)
        .scrollContentBackground(.hidden)
        
        VStack(spacing: 15) {
          HStack {
            Text("Total Amount:")
              .font(.poppins(.medium, size: 15))
              .foregroundStyle(.cstGray)
            Spacer()
            Text("₴ \(String(format: "%.2f", 50.0))")
              .font(.poppins(.bold, size: 18))
              .foregroundStyle(.cstWhite)
          }
          CustomSeparator()
          CustomBtn("Confirm") {
            // get back to order options screen
            dismiss()
          }
        }
        .padding(.horizontal, 25)
        .padding(.bottom, UIScreen.current?.bounds.height == 667 ? 20 : 0)
      }
    }
    .navigationTitle("Assembler")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        ArrowBackBtn()
      }
    }
  }
}

#Preview {
  AssemblerScreen()
}
