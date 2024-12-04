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
    NavigationStack {
      ZStack {
        Color.cstDarkBrown.ignoresSafeArea()
        
        VStack(alignment: .leading, spacing: 30) {
          // Header
          VStack(alignment: .leading, spacing: 15) {
            Text("Sign Up")
              .foregroundStyle(.cstCream)
              .font(.poppins(.medium, size: 20))
            Text("Create an account here.")
              .font(.poppins(.regular, size: 14))
              .foregroundStyle(.cstGray)
          }
          
          SignUpForm()
          
          HStack {
            Spacer()
            CustomBtn("Sign Up") {
              isShownCodeConfirmation.toggle()
            }
          }
          
          HStack(spacing: 5) {
            Text("Already a member?")
              .font(.poppins(.regular, size: 13))
              .foregroundStyle(.cstGray)
            Button("Sign In") {
              dismiss()
            }
            .font(.poppins(.medium, size: 15))
            .foregroundStyle(.cstCream)
          }
        }
        .padding(.horizontal, 30)
        .sheet(isPresented: $isShownCodeConfirmation) {
          CodeConfirmationView()
            .presentationDetents([.medium])
            .presentationCornerRadius(20)
            .presentationDragIndicator(.visible)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            ArrowBackBtn()
          }
        }
      }
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
        }.pickerStyle(.segmented)
      }
    }
  }
}

#Preview {
  SignUpScreen()
}
