//
//  OrderCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct OrderCell: View {
    let coffee: String
    let address: String
    let price: Double
    
    private var date: String {
        return "24 June | 12:30 | by 18:10"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(date)
                    .font(.poppins(.medium, size: 10))
                    .foregroundStyle(.primaryGray)
                Spacer()
                Text("UAH \(String(format: "%.2f", price))")
                    .font(.poppins(.medium, size: 16))
                    .foregroundStyle(.primaryReversed)
            }
            OrderRow(content: coffee, imageName: "coffeeCup")
            OrderRow(content: address, imageName: "location")
        }
        .padding(.horizontal, 30)
    }
}

struct OrderRow: View {
    let content: String
    let imageName: String
    
    var body: some View {
        HStack {
            Image(imageName)
                .resizable()
                .frame(width: 15, height: 15)
            Text(content)
                .font(.poppins(.medium, size: 12))
                .foregroundStyle(.primaryReversed)
        }
    }
}

#Preview {
    OrderCell(
        coffee: "Americano",
        address: "Bradford St.1",
        price: 35.00
    )
}
