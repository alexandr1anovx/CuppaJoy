//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct SignUpScreen: View {
  
  @State private var fullName = ""
  @State private var email = ""
  @State private var password = ""
  @State private var selectedCity: City = .mykolaiv
  
  @FocusState private var fieldContent: InputContentType?
  @EnvironmentObject var authViewModel: AuthViewModel
  @Environment(\.dismiss) var dismiss
  
  private let validationService = ValidationService.shared
  
  private var isValidForm: Bool {
    validationService.isValid(fullName: fullName)
    && validationService.isValid(email: email)
    && validationService.isValid(password: password)
  }
  
  var body: some View {
    ZStack {
      Color.csBlack.ignoresSafeArea(.all)
      ScrollView {
        VStack(spacing: 0) {
          textFields
          cityPicker.padding(23)
          signUpButton
          signInOption.padding(.vertical, 15)
          Spacer()
        }
      }
      .navigationTitle("Sign Up")
      .navigationBarTitleDisplayMode(.inline)
    }
    .onAppear {
      setupSegmentedControlAppearance()
    }
  }
  
  private var textFields: some View {
    List {
      Section {
        InputField(for: .fullName, data: $fullName)
          .focused($fieldContent, equals: .fullName)
          .textInputAutocapitalization(.words)
          .submitLabel(.next)
          .onSubmit { fieldContent = .email }
        
        InputField(for: .email, data: $email)
          .focused($fieldContent, equals: .email)
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .submitLabel(.next)
          .onSubmit { fieldContent = .password }
        
        SecuredInputField(password: $password)
          .focused($fieldContent, equals: .password)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .submitLabel(.done)
          .onSubmit { fieldContent = nil }
      } header: {
        Text("Fill in the fields")
          .font(.caption)
          .fontWeight(.semibold)
          .padding(.bottom, 10)
      } footer: {
        VStack(alignment: .leading, spacing: 6) {
          Text("- Full name cannot be empty.")
          Text("- Email address format: name@example.com.")
          Text("- Password must be at least 8 characters,")
          Text("- contain at least one letter,")
          Text("- contain at least one number.")
        }
        .font(.caption)
        .padding(.top, 10)
      }
    }
    .customListStyle(rowSpacing: 8, shadowRadius: 5)
    .frame(height: 325)
    .environment(\.defaultMinListRowHeight, 50)
  }
  
  private var cityPicker: some View {
    VStack(alignment: .leading) {
      Text("Select your city:")
        .font(.footnote)
        .foregroundStyle(.gray)
      Picker("City", selection: $selectedCity) {
        ForEach(City.allCases) { city in
          Text(city.title)
        }
      }.pickerStyle(.segmented)
    }
  }
  
  private var signUpButton: some View {
    Button {
      Task {
        await authViewModel.signUp(
          fullName: fullName,
          email: email,
          password: password,
          city: selectedCity
        )
      }
    } label: {
      ButtonLabel(
        "Sign Up",
        textColor: .white,
        bgColor: .black
      )
    }
    .disabled(!isValidForm)
    .opacity(!isValidForm ? 0.3 : 1)
  }
  
  private var signInOption: some View {
    Button {
      dismiss()
    } label: {
      HStack {
        Text("Already have an account?")
          .font(.footnote)
          .foregroundStyle(.gray)
        Text("Sign In.")
          .font(.subheadline)
          .fontWeight(.semibold)
          .foregroundStyle(.csCream)
      }
    }
  }
}

#Preview {
  SignUpScreen()
    .environmentObject( AuthViewModel() )
}
