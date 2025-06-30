//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct RegistrationScreen: View {
  
  //@StateObject var viewModel: RegistrationViewModel
  @EnvironmentObject var viewModel: RegistrationViewModel
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
      .navigationTitle("Sign Up")
      .navigationBarTitleDisplayMode(.inline)
    }
    .onAppear {
      setupSegmentedControlAppearance()
    }
  }
  
  // MARK: - Subviews
  
  private var textFields: some View {
    List {
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
    .listRowSpacing(8)
    .frame(height: 325)
    .environment(\.defaultMinListRowHeight, 50)
    .shadow(radius: 5)
  }
  
  private var cityPicker: some View {
    VStack(alignment: .leading) {
      Text("Select your city:")
        .font(.footnote)
        .foregroundStyle(.gray)
      Picker("City", selection: $viewModel.selectedCity) {
        ForEach(City.allCases) { city in
          Text(city.title)
        }
      }.pickerStyle(.segmented)
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
    .alert(item: $viewModel.alertItem) { alert in
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
