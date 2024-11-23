//
//  VerificationView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 09.10.2024.
//

import SwiftUI

struct SMSConfirmationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.primaryBrown.ignoresSafeArea()
                
            
            VStack(spacing: 30) {
                HStack {
                    HeaderLabel(
                        title: "Verification",
                        subtitle: "Enter the code we sent to your phone number"
                    )
                    Spacer()
                }
               
                HStack(spacing: 20) {
                    ForEach(0..<4) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.primaryBlue)
                            .frame(width: 45, height: 55)
                    }
                }
                Text("Resend in 00:30")
                    .font(.poppins(.regular, size: 15))
                    .foregroundStyle(.primaryWhite)
            }
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    SMSConfirmationView()
}
