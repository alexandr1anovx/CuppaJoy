//
//  CoffeeCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 30.11.2024.
//

import SwiftUI

struct CoffeeCell: View {
    let coffee: Coffee
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.cstCream
                    .shadow(.inner(color: .cstBlack, radius: 2, y: 3))
                    .shadow(.drop(color: .cstBlack, radius: 2)))
            
            VStack(spacing: 0) {
                Image("coffeeCup")
                    .resizable()
                    .frame(width: 120, height: 100)
                Text(coffee.rawValue)
                    .font(.poppins(.medium, size: 14))
                    .foregroundStyle(.cstDarkBrown)
            }
        }.frame(width: 140, height: 140)
    }
}

#Preview {
    CoffeeCell(coffee: .americano)
}
