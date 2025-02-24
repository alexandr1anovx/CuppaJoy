//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct SignUpScreen: View {
  
  // MARK: Properties
  @State private var username = ""
  @State private var phoneNumber = ""
  @State private var emailAddress = ""
  @State private var selectedCity: City = .mykolaiv
  @State private var confirmationCode = ""
  @State private var isShownConfirmationAlert = false
  @FocusState private var fieldContent: TextFieldContentType?
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
  
  private var isValidForm: Bool {
    authenticationViewModel.isValidUsername(username)
    && authenticationViewModel.isValidPhoneNumber(phoneNumber)
    && authenticationViewModel.isValidEmail(emailAddress)
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
          textFieldList
          cityPicker.padding(20)
          signUpButton.padding(.top, 10)
          signInOption.padding(.top, 15)
          Spacer()
        }
        .padding(.top, 20)
        .navigationBarBackButtonHidden(true)
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            ReturnButton()
          }
        }
      }
    }
    .scrollIndicators(.hidden)
  }
  
  // MARK: Text Fields
  private var textFieldList: some View {
    List {
      CSTextField(for: .username, inputData: $username)
        .focused($fieldContent, equals: .username)
        .textInputAutocapitalization(.words)
        .submitLabel(.next)
        .onSubmit { fieldContent = .phoneNumber }
      
      CSTextField(for: .phoneNumber, inputData: $phoneNumber)
        .focused($fieldContent, equals: .phoneNumber)
        .submitLabel(.next)
        .onSubmit { fieldContent = .emailAddress }
      
      CSTextField(for: .emailAddress, inputData: $emailAddress)
        .focused($fieldContent, equals: .emailAddress)
        .keyboardType(.emailAddress)
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
      isShownConfirmationAlert.toggle()
    } label: {
      ButtonLabel("Sign Up", textColor: .white, pouring: .black)
    }
    .disabled(!isValidForm)
    .opacity(isValidForm ? 1 : 0.5)
    
    .alert("Code Confirmation", isPresented: $isShownConfirmationAlert) {
      TextField("Code", text: $confirmationCode)
      Button("Confirm", role: .destructive) {
        // check if the code is correct:
        // if not, show an alert with an error
        // if true, show the home screen after loading 2 seconds.
      }
    } message: {
      Text("Enter the code from SMS.")
    }
  }
  
  // MARK: Option "Already a member? SignIn"
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
