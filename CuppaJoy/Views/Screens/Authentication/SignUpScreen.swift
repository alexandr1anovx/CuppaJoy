//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

// Should be moved to the view model in the future.
enum AuthFieldContent: Hashable {
  case username
  case phoneNumber
  case email
}

// Should be moved to the view model in the future.
enum City: String, CaseIterable {
  case mykolaiv = "Mykolaiv"
  case odesa = "Odesa"
}

struct SignUpScreen: View {
  
  // MARK: Stored Properties
  @State private var username = ""
  @State private var phoneNumber = ""
  @State private var email = ""
  @State private var selectedCity: City = .mykolaiv
  @State private var confirmationCode = ""
  @State private var isShownConfirmationAlert = false
  @FocusState private var fieldContent: AuthFieldContent?
  @Environment(\.dismiss) var dismiss
  
  // MARK: Computed Properties
  private var isValidForm: Bool {
    isValidUsername(username)
    && isValidPhoneNumber(phoneNumber)
    && isValidEmail(email)
  }
  
  // Custom Picker Style
  init() {
    UISegmentedControl.appearance().selectedSegmentTintColor = .csBrown
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    UISegmentedControl.appearance().backgroundColor = .black
  }
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      
      ScrollView {
        VStack(spacing: 0) {
          AuthHeaderView(authAction: .signUp)
          
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
  
  // MARK: Text Field List
  private var textFieldList: some View {
    List {
      CSTextField(
        icon: "person",
        hint: "Full name",
        inputData: $username
      )
      .focused($fieldContent, equals: .username)
      .textInputAutocapitalization(.words)
      .submitLabel(.next)
      .onSubmit { fieldContent = .phoneNumber }
      
      CSTextField(
        icon: "phone",
        hint: "Phone number",
        inputData: $phoneNumber
      )
      .focused($fieldContent, equals: .phoneNumber)
      .submitLabel(.next)
      .onSubmit { fieldContent = .email }
      
      CSTextField(
        icon: "envelope",
        hint: "user@example.com",
        inputData: $email
      )
      .focused($fieldContent, equals: .email)
      .keyboardType(.emailAddress)
      .textInputAutocapitalization(.never)
      .autocorrectionDisabled(true)
      .submitLabel(.done)
      .onSubmit { fieldContent = nil }
    }
    .frame(height: 185)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
  }
  
  // MARK: City Picker
  private var cityPicker: some View {
    VStack(alignment: .leading) {
      Text("Select your city:")
        .font(.footnote)
        .foregroundStyle(.gray)
        .padding(.leading, 5)
      Picker("City", selection: $selectedCity) {
        ForEach(City.allCases, id: \.self) { city in
          Text(city.rawValue)
        }
      }.pickerStyle(.segmented)
    }
  }
  
  // MARK: Sign Up button
  private var signUpButton: some View {
    CSButton("Sign Up", bgColor: .csDesert) {
      isShownConfirmationAlert.toggle()
    }
    .disabled(!isValidForm)
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
  
  // MARK: Sign In Option
  private var signInOption: some View {
    Button {
      dismiss()
    } label: {
      HStack(spacing: 5) {
        Text("Already a member?")
          .font(.footnote)
          .foregroundStyle(.gray)
        Text("Sign In.")
          .font(.callout).bold()
          .foregroundStyle(.csCream)
      }
    }
  }
  
  // Data validation methods. Should be moved to the view model in the future.
  
  private func isValidUsername(_ username: String) -> Bool {
    let regex = #"^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: username)
  }
  
  private func isValidPhoneNumber(_ phone: String) -> Bool {
    // works only for ukrainian format.
    let regex = #"^(\+380|0)\d{9}$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: phoneNumber)
  }
  
  private func isValidEmail(_ email: String) -> Bool {
    let regex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
    let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)
    return predicate.evaluate(with: email)
  }
}

#Preview {
  SignUpScreen()
}
