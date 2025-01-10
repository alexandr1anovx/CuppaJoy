//
//  VerificationView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 09.10.2024.
//

import SwiftUI

struct CodeConfirmationView: View {
  @State private var confirmationCode = ""
  
  var body: some View {
    ZStack {
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 30) {
        AuthHeaderView(
          title: "Verification", 
          subtitle: "Enter the code we sent to your phone number."
        )
        
        CustomTextField(
          image: "mailbox",
          placeholder: "Confirmation code",
          inputData: $confirmationCode)
        
        Text("Resend in 00:30")
          .font(.poppins(.medium, size: 14))
          .foregroundStyle(.cstCream)
          .opacity(0.7)
        HStack {
          Spacer()
          
          Button {
            // action
          } label: {
            Text("Confirm")
              .font(.poppins(.medium, size: 14))
              .foregroundStyle(.cstDarkBrown)
              .padding(5)
          }
          .tint(.cstCream)
          .buttonStyle(.borderedProminent)
        }
      }
      .padding(.horizontal, 25)
    }
  }
}

#Preview {
  CodeConfirmationView()
}
