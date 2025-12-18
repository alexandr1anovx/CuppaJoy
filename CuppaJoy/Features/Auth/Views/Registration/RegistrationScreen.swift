//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct RegistrationScreen: View {
  
  @State var viewModel: RegistrationViewModel
  @FocusState private var fieldContent: InputContentType?
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack {
      Color.appBackgroundDimmed.ignoresSafeArea()
      ScrollView {
        VStack(spacing: 0) {
          textFields
          cityPicker.padding(23)
          signUpButton
          signInOption.padding(.vertical, 15)
          Spacer()
        }
      }
      .navigationTitle("Registration")
      .navigationBarTitleDisplayMode(.inline)
    }
    .environment(viewModel)
    .onAppear {
      setupSegmentedControlAppearance()
    }
  }
  
  // MARK: - Subviews
  
  private var textFields: some View {
    Form {
      Section {
        InputField(for: .fullName, data: $viewModel.fullName)
          .focused($fieldContent, equals: .fullName)
          .textInputAutocapitalization(.words)
          .submitLabel(.next)
          .onSubmit { fieldContent = .email }
        
        InputField(for: .email, data: $viewModel.email)
          .focused($fieldContent, equals: .email)
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .submitLabel(.next)
          .onSubmit { fieldContent = .password }
        
        SecuredInputField(password: $viewModel.password)
          .focused($fieldContent, equals: .password)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .submitLabel(.done)
          .onSubmit { fieldContent = .confirmPassword }
        
        SecuredInputField(password: $viewModel.confirmedPassword)
          .focused($fieldContent, equals: .confirmPassword)
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
        VStack(alignment: .leading, spacing: 10) {
          Text("- Full name cannot be empty.")
          Text("- Email address format: name@example.com.")
          Text("- Password must be at least 8 characters, contain at least one letter and one number.")
        }
        .font(.caption)
        .padding(.top, 10)
      }
    }
    .scrollContentBackground(.hidden)
    .listRowSpacing(8)
    .frame(height: 370)
    .environment(\.defaultMinListRowHeight, 50)
    .shadow(radius: 5)
  }
  
  private var cityPicker: some View {
    HStack(spacing:0) {
      Text("Select your city:")
        .font(.footnote)
        .foregroundStyle(.gray)
      Picker("Select your city:", selection: $viewModel.selectedCity) {
        ForEach(City.allCases) { city in
          Text(city.rawValue)
        }
      }
    }
  }
  
  private var signUpButton: some View {
    Button {
      Task { await viewModel.signUp() }
    } label: {
      ButtonLabel("Sign Up", textColor: .white, bgColor: .black)
    }
    .disabled(!viewModel.isValidForm)
    .opacity(!viewModel.isValidForm ? 0.3 : 1)
    .alert(item: $viewModel.alert) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
  }
  
  private var signInOption: some View {
    Button {
      dismiss()
    } label: {
      HStack {
        Text("Already have an account?")
          .foregroundStyle(.gray)
        Text("Sign In.")
          .fontWeight(.semibold)
          .foregroundStyle(.csCream)
      }
      .font(.footnote)
    }
  }
}
