//
//  SugarCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import SwiftUI

struct SugarCell: View {
  
  @Binding var sugarSticks: Int
  
  var body: some View {
    HStack {
      Text("Sugar sticks:")
      Spacer()
      Button("-") {
        withAnimation { sugarSticks -= 1 }
      }
      .disabled(sugarSticks == 0)
      .buttonStyle(.bordered)
      
      Text("\(sugarSticks)")
        .frame(minWidth: 20)
        .contentTransition(.numericText(value: Double(sugarSticks)))
      
      Button("+") {
        withAnimation { sugarSticks += 1 }
      }
      .disabled(sugarSticks == 3)
      .buttonStyle(.bordered)
    }
    .font(.callout)
    .fontWeight(.medium)
    .foregroundStyle(.white)
  }
}

#Preview {
  SugarCell(sugarSticks: .constant(2))
}
