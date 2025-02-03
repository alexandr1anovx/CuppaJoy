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
      Color.appBackground.ignoresSafeArea(.all)
      VStack(alignment: .center, spacing: 0) {
        AuthHeaderView(title: "Verification.", subtitle: "Enter the code from SMS.")
        textFieldList
        resendCodeButton.padding(.top, 20)
        confirmButton.padding(.top, 20)
      }
    }
  }
  
  // MARK: Text Field list
  private var textFieldList: some View {
    List {
      CSTextField(
        icon: "numbers",
        prompt: "Code",
        inputData: $confirmationCode
      )
    }
    .listStyle(.insetGrouped)
    .frame(height: 85)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
    .shadow(radius: 8)
  }
  
  // MARK: Resend code button
  private var resendCodeButton: some View {
    Button("Resend in 00:30") {
      // action
    }
    .font(.poppins(.medium, size: 14))
    .foregroundStyle(.gray)
    .shadow(radius: 8)
  }
  
  // MARK: - Confirm button
  private var confirmButton: some View {
    Button {
      // logic
    } label: {
      Text("Confirm")
        .font(.poppins(.bold, size: 15))
        .foregroundStyle(.white)
        .padding(.vertical, 8)
        .padding(.horizontal, 130)
    }
    .tint(.csDesert)
    .buttonStyle(.borderedProminent)
    .shadow(radius: 8)
  }
}

#Preview {
  CodeConfirmationView()
}
