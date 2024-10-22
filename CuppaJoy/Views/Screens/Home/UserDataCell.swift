//
//  UserDataCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.10.2024.
//

import SwiftUI

struct UserDataCell: View {
    let image: String
    let header: String
    let content: String
    
    var body: some View {
        HStack(spacing: 15) {
            CircleWithImage(imageName: image)
            TextContent(header: header, content: content)
            Spacer()
            Image(systemName: "highlighter")
                .font(.title3)
                .foregroundStyle(.primaryReversed)
                .onTapGesture {
                    // Modify selected text field
                    print("Edit button pressed")
                }
        }.padding(.horizontal, 30)
    }
}

struct CircleWithImage: View {
    let imageName: String
    
    var body: some View {
        Circle()
            .fill(Color.primaryWhite)
            .frame(width: 35, height: 35)
            .overlay(alignment: .center) {
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(.primaryBrown)
            }
    }
}

struct TextContent: View {
    let header: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
                .font(.poppins(.medium, size: 12))
                .foregroundStyle(.primaryGray)
            Text(content)
                .font(.poppins(.medium, size: 14))
                .foregroundStyle(.primaryReversed)
        }
    }
}

#Preview {
    UserDataCell(
        image: "person",
        header: "Name",
        content: "Alexander"
    )
}
