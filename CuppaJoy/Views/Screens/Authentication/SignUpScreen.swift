//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

enum City: String, CaseIterable {
  case mykolaiv
  case kyiv
  
  var title: String { self.rawValue.capitalized }
}

struct SignUpScreen: View {
  
  @State private var initials = ""
  @State private var phoneNumber = ""
  @State private var email = ""
  @State private var selectedCity = City.mykolaiv
  @State private var isShownConfirmationSheet = false
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack {
      Color.mainGradientBackground.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 35) {
        AuthHeaderView(title: "Sign Up", subtitle: "Create an account here.")
        signUpForm
        HStack {
          signInButton
          Spacer()
          signUpButton
        }
        Spacer()
      }
      .padding(.top, 20)
      .padding(.horizontal, 20)
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
  
  private var signUpForm: some View {
    VStack(spacing: 30) {
      CustomTextField(
        image: .man,
        placeholder: "name and surname",
        inputData: $initials
      )
      CustomTextField(
        image: .mobile,
        placeholder: "phone number",
        inputData: $phoneNumber
      )
      Picker("City", selection: $selectedCity) {
        ForEach(City.allCases, id: \.self) { city in
          Text(city.title)
        }
      }
      .pickerStyle(.segmented)
      .colorMultiply(.white)
    }
  }
  
  private var signInButton: some View {
    Button {
      dismiss()
    } label: {
      VStack(spacing: 8) {
        Text("Already a member?")
          .font(.footnote)
          .foregroundStyle(.gray)
        Text("Sign In")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundStyle(.white)
      }
      .fontDesign(.rounded)
      .padding(12)
      .background(Color.black)
      .clipShape(.buttonBorder)
    }
  }
  
  private var signUpButton: some View {
    Button {
      isShownConfirmationSheet.toggle()
    } label: {
      Text("Sign Up")
        .font(.callout)
        .fontWeight(.medium)
        .fontDesign(.rounded)
        .foregroundStyle(.white)
        .padding(15)
        .background(.black)
        .clipShape(.buttonBorder)
    }
  }
}

#Preview {
  SignUpScreen()
}
