//
//  CupSizeCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.01.2025.
//

import SwiftUI

struct CupSizeCell: View {
  @State private var selectedSize = CoffeeCup.small
  
  init() {
    UISegmentedControl.appearance().selectedSegmentTintColor = .csYellow
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    UISegmentedControl.appearance().backgroundColor = .csDarkBrown
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Size:")
        .font(.poppins(.medium, size: 15))
        .foregroundStyle(.white)
      Picker("", selection: $selectedSize) {
        ForEach(CoffeeCup.allCases, id: \.self) { size in
          Text(size.title)
        }
      }
      .pickerStyle(.segmented)
    }
    .listRowBackground(Color.csDarkBrown)
  }
}

#Preview {
  CupSizeCell()
}
