//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

enum City: String, CaseIterable {
  case mykolaiv = "Mykolaiv"
  case kyiv = "Kyiv"
}

struct SignUpScreen: View {
  @State private var isShownCodeConfirmation = false
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack {
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 40) {
        AuthHeaderView(title: "Sign Up", subtitle: "Create an account here.")
        
        SignUpForm()
        
        HStack {
          VStack(spacing: 5) {
            Text("Already a member?")
              .font(.poppins(.regular, size: 12))
              .foregroundStyle(.cstGray)
            Button("Sign In") {
              dismiss()
            }
            .font(.poppins(.bold, size: 15))
            .foregroundStyle(.cstCream)
          }
          
          Spacer()
          
          Button {
            isShownCodeConfirmation.toggle()
          } label: {
            Text("Sign Up")
              .font(.poppins(.bold, size: 15))
              .foregroundStyle(.cstMint)
              .padding(5)
          }
          .tint(.cstCream)
        }
        
        Spacer()
      }
      .padding(25)
      .sheet(isPresented: $isShownCodeConfirmation) {
        CodeConfirmationView()
          .presentationDetents([.medium])
          .presentationCornerRadius(20)
          .presentationDragIndicator(.visible)
      }
      .navigationBarBackButtonHidden(true)
    }
  }
}

// MARK: View Components
private extension SignUpScreen {
  
  struct SignUpForm: View {
    @State private var initials = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    @State private var city: City = .mykolaiv
    
    var body: some View {
      VStack(spacing: 25) {
        CustomTextField(
          image: "user",
          placeholder: "Name and surname",
          inputData: $initials
        )
        CustomTextField(
          image: "phone",
          placeholder: "Phone Number",
          inputData: $phoneNumber
        )
        Picker("City", selection: $city) {
          ForEach(City.allCases, id: \.self) { city in
            Text(city.rawValue)
          }
        }
        .pickerStyle(.segmented)
        .colorMultiply(.cstCream)
      }
    }
  }
}

#Preview {
  SignUpScreen()
}
