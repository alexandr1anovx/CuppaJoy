//
//  VerificationView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 09.10.2024.
//

import SwiftUI

struct SMSVerificationScreen: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.primarySystem.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 35) {
                HeaderLabels(
                    title: "Verification",
                    subtitle: "Enter the OTP code we sent you"
                )
                HStack(spacing: 20) {
                    ForEach(0..<4) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.primaryWhite)
                            .frame(width: 45, height: 55)
                    }
                }
                Text("Resend in 00:30")
                    .font(.poppins(.regular, size: 15))
                    .foregroundStyle(.primaryGray)
            }
        }
    }
}

#Preview {
    SMSVerificationScreen()
}
