//
//  VerificationView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 09.10.2024.
//

import SwiftUI

struct CodeConfirmationView: View {
  
  @Environment(\.dismiss) var dismiss
  @State private var confirmationCode = ""
  
  var body: some View {
    ZStack {
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 30) {
        // Header
        VStack(alignment: .leading, spacing: 15) {
          Text("Verification")
            .foregroundStyle(.cstCream)
            .font(.poppins(.medium, size: 20))
          Text("Enter the code we sent to your phone number.")
            .font(.poppins(.regular, size: 13))
            .foregroundStyle(.cstGray)
        }
        
        CustomTextField(
          image: "mailbox",
          placeholder: "Confirmation code",
          inputData: $confirmationCode)
        
        Text("Resend in 00:30")
          .font(.poppins(.medium, size: 14))
          .foregroundStyle(.cstLightPink)
          .opacity(0.7)
        HStack {
          Spacer()
          
          Button {
            // action
          } label: {
            Text("Confirm")
              .font(.poppins(.medium, size: 16))
              .foregroundStyle(.cstCream)
              .padding(5)
          }
          .tint(.cstCream)
          .buttonStyle(.bordered)
        }
      }
      .padding(.horizontal, 30)
    }
  }
}

#Preview {
  CodeConfirmationView()
}
