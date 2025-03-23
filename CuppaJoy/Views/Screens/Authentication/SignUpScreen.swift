//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct SignUpScreen: View {
  
  @State private var fullName = ""
  @State private var emailAddress = ""
  @State private var password = ""
  @State private var selectedCity: City = .mykolaiv
  
  @FocusState private var fieldContent: TextFieldContentType?
  @EnvironmentObject var authViewModel: AuthViewModel
  @Environment(\.dismiss) var dismiss
  
  private var isValidForm: Bool {
    authViewModel.isValidFullName(fullName)
    && authViewModel.isValidEmail(emailAddress)
    && authViewModel.isValidPassword(password)
  }
  
  var body: some View {
    ZStack {
      Color.csBlack.ignoresSafeArea(.all)
      ScrollView {
        VStack(spacing: 0) {
          AuthHeaderView(for: .signUp)
          textFields
          cityPicker.padding(20)
          signUpButton.padding(.top, 5)
          signInOption.padding(.top, 15)
          Spacer()
        }.padding(.top, 20)
      }
    }
    .onAppear {
      setupSegmentedControlAppearance()
    }
  }
  
  private var textFields: some View {
    List {
      DefaultTextField(for: .username, inputData: $fullName)
        .focused($fieldContent, equals: .username)
        .textInputAutocapitalization(.words)
        .submitLabel(.next)
        .onSubmit { fieldContent = .emailAddress }
      
      DefaultTextField(for: .emailAddress, inputData: $emailAddress)
        .focused($fieldContent, equals: .emailAddress)
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .submitLabel(.next)
        .onSubmit { fieldContent = .password }
      
      SecuredTextField(password: $password)
        .focused($fieldContent, equals: .password)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .submitLabel(.done)
        .onSubmit { fieldContent = nil }
    }
    .frame(height: 190)
    .environment(\.defaultMinListRowHeight, 50)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
    .shadow(radius: 5)
  }
  
  private var cityPicker: some View {
    VStack(alignment: .leading) {
      Text("Select your city:")
        .font(.footnote)
        .fontWeight(.semibold)
        .foregroundStyle(.gray)
        .padding(.leading, 5)
      Picker("City", selection: $selectedCity) {
        ForEach(City.allCases, id: \.self) { city in
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
          email: emailAddress,
          password: password,
          city: selectedCity
        )
      }
    } label: {
      ButtonLabel("Sign Up", textColor: .white, pouring: .black)
    }
    .disabled(!isValidForm)
    .opacity(!isValidForm ? 0.5 : 1)
  }
  
  private var signInOption: some View {
    Button {
      dismiss()
    } label: {
      HStack(spacing: 5) {
        Text("Already have an account?")
          .font(.footnote)
          .fontWeight(.medium)
          .foregroundStyle(.gray)
        Text("Sign In.")
          .font(.subheadline)
          .fontWeight(.bold)
          .foregroundStyle(.csCream)
      }
    }
  }
  
  private func setupSegmentedControlAppearance() {
    let appearance = UISegmentedControl.appearance()
    appearance.selectedSegmentTintColor = .csBrown
    appearance.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    appearance.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    appearance.backgroundColor = .black
  }
}

#Preview {
  SignUpScreen()
    .environmentObject( AuthViewModel() )
}
