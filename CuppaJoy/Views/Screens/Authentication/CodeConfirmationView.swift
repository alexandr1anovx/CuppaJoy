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
      Color.mainGradientBackground.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 20) {
        AuthHeaderView(
          title: "Verification", 
          subtitle: "Enter the code we sent to your phone number."
        )
        
        CustomTextField(
          image: .envelope,
          placeholder: "Confirmation code",
          inputData: $confirmationCode)
        .padding(.top)
        
        Text("Resend in 00:30")
          .font(.poppins(.medium, size: 13))
          .foregroundStyle(.gray)
        HStack {
          Spacer()
          
          Button {
            // action
          } label: {
            Text("Confirm")
              .font(.poppins(.medium, size: 14))
              .foregroundStyle(.white)
              .padding(6)
          }
          .tint(.black)
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
