//
//  UserDataCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.10.2024.
//

import SwiftUI

struct ProfileContentCell: View {
    let image: String
    let header: String
    let content: String
    
    var body: some View {
        HStack(spacing: 10) {
            
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.cstCream)
                .frame(width: 35, height: 35)
                
                .overlay(alignment: .center) {
                    Image(image)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.cstDarkBrown)
                }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(header)
                    .font(.poppins(.medium, size: 12))
                    .foregroundStyle(.cstWhite)
                Text(content)
                    .font(.poppins(.medium, size: 14))
                    .foregroundStyle(.cstCream)
            }
            
            Spacer()
            Image(systemName: "highlighter")
                .font(.title3)
                .foregroundStyle(.cstGray)
                .onTapGesture {
                    // Modify selected text field
                }
        }
        .padding(.horizontal, 30)
    }
}

#Preview {
    ProfileContentCell(
        image: "user",
        header: "Name",
        content: "Alexander"
    )
}
