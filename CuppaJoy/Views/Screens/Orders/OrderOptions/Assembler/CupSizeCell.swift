//
//  CupSizeCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.01.2025.
//

import SwiftUI

struct CupSizeCell: View {
  @State private var selectedSize = CoffeeCup.small
  
  // Picker Style Customization
  init() {
    UISegmentedControl.appearance().selectedSegmentTintColor = .csBrown
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    UISegmentedControl.appearance().backgroundColor = .black
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Size:")
        .font(.subheadline)
        .fontDesign(.monospaced)
      Picker("", selection: $selectedSize) {
        ForEach(CoffeeCup.allCases, id: \.self) { size in
          Text(size.title)     
        }
      }.pickerStyle(.segmented)
    }
  }
}

#Preview {
  CupSizeCell()
}
