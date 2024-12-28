//
//  BaristaScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

struct BaristaScreen: View {
  var body: some View {
    ZStack {
      Color.cstDarkBrown.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 0) {
        
        Text("Select a barista")
          .font(.poppins(.medium, size: 15))
          .foregroundStyle(.cstGray)
          .padding(.leading, 25)
        
        List {
          BaristaCell()
            .listRowBackground(Color.cstBrown)
          BaristaCell()
            .listRowBackground(Color.cstBrown)
          BaristaCell()
            .listRowBackground(Color.cstBrown)
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(20)
        .scrollContentBackground(.hidden)
      }
    }
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        ArrowBackBtn()
      }
    }
  }
}
