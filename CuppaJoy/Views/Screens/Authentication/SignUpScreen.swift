//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

enum City: String, CaseIterable {
  case mykolaiv, kyiv
  
  var title: String { self.rawValue.capitalized }
}

struct SignUpScreen: View {
  @State private var isShownConfirmationSheet = false
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack {
      Color.mainGradientBackground.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 40) {
        AuthHeaderView(title: "Sign Up", subtitle: "Create an account here.")
        
        SignUpForm()
        
        HStack {
          VStack(spacing: 5) {
            Text("Already a member?")
              .font(.poppins(.regular, size: 12))
              .foregroundStyle(.gray)
            Button("Sign In") {
              dismiss()
            }
            .font(.poppins(.bold, size: 14))
            .foregroundStyle(.white)
          }
          
          Spacer()
          
          Button {
            isShownConfirmationSheet.toggle()
          } label: {
            Text("Sign Up")
              .font(.poppins(.bold, size: 14))
              .foregroundStyle(.accent)
              .padding(5)
          }
          .tint(.accent)
        }
        
        Spacer()
      }
      .padding(.top)
      .padding(25)
      .sheet(isPresented: $isShownConfirmationSheet) {
        CodeConfirmationView()
          .presentationDetents([.medium])
          .presentationCornerRadius(20)
          .presentationDragIndicator(.visible)
      }
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          ReturnButton()
        }
      }
    }
  }
}

private struct SignUpForm: View {
  
  @State private var initials = ""
  @State private var phoneNumber = ""
  @State private var email = ""
  @State private var city = City.mykolaiv
  
  var body: some View {
    VStack(spacing: 25) {
      CustomTextField(
        image: .man,
        placeholder: "Name and surname",
        inputData: $initials
      )
      CustomTextField(
        image: .mobile,
        placeholder: "Phone Number",
        inputData: $phoneNumber
      )
      Picker("City", selection: $city) {
        ForEach(City.allCases, id: \.self) { city in
          Text(city.title)
        }
      }
      .pickerStyle(.segmented)
      .colorMultiply(.white)
    }
  }
}

#Preview {
  SignUpScreen()
}
