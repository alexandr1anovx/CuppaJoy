//
//  VerificationView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 09.10.2024.
//

import SwiftUI

struct SMSConfirmationView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var code = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.primaryBrown.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 30) {
                    HeaderView(
                        title: "Verification",
                        subtitle: "Enter the code we sent to your phone number")
                    
                    CustomTextField(
                        imageName: "mailbox",
                        placeholder: "Confirmation code",
                        inputData: $code)
                    
                    Text("Resend in 00:30")
                        .font(.poppins(.medium, size: 15))
                        .foregroundStyle(.primaryGreen)
                    HStack {
                        Spacer()
                        MainButton("Confirm", action: {})
                    }
                }
                .padding(.horizontal, 30)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        BackButton()
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview { SMSConfirmationView() }
#endif
