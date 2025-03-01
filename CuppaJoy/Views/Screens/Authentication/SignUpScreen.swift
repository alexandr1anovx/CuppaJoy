//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct SignUpScreen: View {
  
  // MARK: Properties
  @State private var fullName = ""
  @State private var emailAddress = ""
  @State private var password = ""
  @State private var selectedCity: City = .mykolaiv
  @State private var isShownConfirmationAlert = false
  @FocusState private var fieldContent: TextFieldContentType?
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  
  @State private var isShown = false
  
  private var isValidForm: Bool {
    authViewModel.isValidFullName(fullName)
    && authViewModel.isValidEmail(emailAddress)
    && authViewModel.isValidPassword(password)
  }
  
  // MARK: Custom Picker Style Initializer
  init() {
    UISegmentedControl.appearance().selectedSegmentTintColor = .csBrown
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    UISegmentedControl.appearance().backgroundColor = .black
  }
  
  // MARK: body
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
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
    .fullScreenCover(isPresented: $isShown) {
      EntryPoint()
    }
  }
  
  // MARK: Text Fields
  private var textFields: some View {
    List {
      CSTextField(for: .username, inputData: $fullName)
        .focused($fieldContent, equals: .username)
        .textInputAutocapitalization(.words)
        .submitLabel(.next)
        .onSubmit { fieldContent = .emailAddress }
      
      CSTextField(for: .emailAddress, inputData: $emailAddress)
        .focused($fieldContent, equals: .emailAddress)
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .submitLabel(.next)
        .onSubmit { fieldContent = .password }
      
      PasswordTextField(password: $password)
        .focused($fieldContent, equals: .password)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .submitLabel(.done)
        .onSubmit { fieldContent = nil }
    }
    .frame(height: 185)
    .shadow(radius: 5)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
  }
  
  // MARK: City Picker
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
  
  // MARK: Button "Sign Up"
  private var signUpButton: some View {
    Button {
      
      Task {
        await authViewModel.signUp(
          fullName: fullName,
          email: emailAddress,
          password: password,
          city: selectedCity
        )
        isShown.toggle()
      }
      
    } label: {
      ButtonLabel("Sign Up", textColor: .white, pouring: .black)
    }
    .disabled(!isValidForm)
    .opacity(isValidForm ? 1 : 0.5)
  }
  
  // MARK: Option "Already a member? Sign In"
  private var signInOption: some View {
    Button {
      dismiss()
    } label: {
      HStack(spacing: 5) {
        Text("Already a member?")
          .font(.footnote)
          .fontWeight(.semibold)
          .foregroundStyle(.gray)
        Text("Sign In.")
          .font(.callout)
          .fontWeight(.bold)
          .foregroundStyle(.csCream)
      }
    }
  }
}

#Preview {
  SignUpScreen()
    .environmentObject(AuthenticationViewModel())
}
