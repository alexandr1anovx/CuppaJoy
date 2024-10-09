//
//  VerificationView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 09.10.2024.
//

import SwiftUI

struct VerificationView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 40) {
                HeaderLabels(
                    title: "Verification",
                    subtitle: "Enter the OTP code we sent you"
                )
                
                HStack(spacing: 20) {
                    ForEach(0..<4) { _ in
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.creamWhite)
                            .frame(width: 48, height: 60)
                    }
                }
                
                // Remaining time
                Text("Resend in 00:30")
                    .font(.poppins(.regular, size: 15))
                    .foregroundStyle(.hotGray)
                    .opacity(0.5)
                
                Spacer()
            }
            .padding(.top, 50)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 20))
                            .foregroundStyle(.darkBrown)
                    }
                }
            }
        }
    }
}

#Preview {
    VerificationView()
}
