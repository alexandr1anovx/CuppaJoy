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
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text(date)
                    .font(.poppins(.medium, size: 12))
                    .foregroundStyle(.cstGray)
                Spacer()
                Text("UAH \(String(format: "%.2f", price))")
                    .font(.poppins(.medium, size: 18))
                    .foregroundStyle(.cstWhite)
            }
            OrderRow(content: coffee, imageName: "coffeeGlass")
            OrderRow(content: address, imageName: "location")
        }
    }
}

struct OrderRow: View {
    let content: String
    let imageName: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(.cstWhite)
            Text(content)
                .font(.poppins(.medium, size: 13))
                .foregroundStyle(.cstMint)
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
