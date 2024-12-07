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
        Color.cstDarkBrown.ignoresSafeArea()
        
        VStack {
          List {
            BaristaCell()
            CoffeeTypeCell()
            SortCell()
            MilkCell()
            SyrupCell()
            AdditiveCell()
            IceCubeCell()
          }
          .listRowSpacing(20)
          .listStyle(.insetGrouped)
          .scrollContentBackground(.hidden)
          
          VStack(spacing: 18) {
            TotalAmountView(amount: 20.00)
            CustomDivider()
            CustomBtn("Next") {
              // some actions
            }
          }
          .padding(.horizontal, 25)
          .padding(.vertical)
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
}

#Preview {
  AssemblerScreen()
}
