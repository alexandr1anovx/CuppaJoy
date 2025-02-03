//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

enum AuthFieldContent: Hashable {
  case username
  case phoneNumber
  case email
}

enum City: String, CaseIterable {
  case mykolaiv = "Mykolaiv"
  case odesa = "Odesa"
}

struct SignUpScreen: View {
  
  // Stored Properties
  @State private var username = ""
  @State private var phoneNumber = ""
  @State private var email = ""
  @State private var selectedCity = City.mykolaiv
  @State private var isShownConfirmationSheet = false
  @FocusState private var fieldContent: AuthFieldContent?
  @Environment(\.dismiss) var dismiss
  
  // Computed Properties
  private var isValidForm: Bool {
    isValidUsername(username)
    && isValidPhoneNumber(phoneNumber)
    && isValidEmail(email)
  }
  
  // Picker Style Customizations
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
          AuthHeaderView(
            title: "Sign Up.",
            subtitle: "Let's create an account."
          )
          textFieldList
          cityPicker.padding(20)
          signUpButton.padding(.top, 10)
          signInOption.padding(.top, 20)
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
    .onAppear { fieldContent = .username }
  }
  
  // MARK: Text Field list
  private var textFieldList: some View {
    List {
      CSTextField(
        icon: "person",
        prompt: "Full name",
        inputData: $username
      )
      .focused($fieldContent, equals: .username)
      .textInputAutocapitalization(.words)
      .submitLabel(.next)
      .onSubmit { fieldContent = .phoneNumber }
      
      CSTextField(
        icon: "phone",
        prompt: "Phone number",
        inputData: $phoneNumber
      )
      .focused($fieldContent, equals: .phoneNumber)
      .submitLabel(.next)
      .onSubmit { fieldContent = .email }
      
      CSTextField(
        icon: "envelope",
        prompt: "user@example.com",
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
    .shadow(radius: 8)
  }
  
  // MARK: City Picker
  private var cityPicker: some View {
    VStack(alignment: .leading) {
      Text("Select your city:")
        .font(.poppins(.regular, size: 13))
        .foregroundStyle(.gray)
        .padding(.leading, 5)
      Picker("City", selection: $selectedCity) {
        ForEach(City.allCases, id: \.self) { city in
          Text(city.rawValue)
        }
      }.pickerStyle(.segmented)
    }.shadow(radius: 8)
  }
  
  // MARK: Sign Up button
  private var signUpButton: some View {
    Button {
      isShownConfirmationSheet.toggle()
    } label: {
      Text("Sign Up")
        .font(.poppins(.bold, size: 15))
        .foregroundStyle(.white)
        .padding(.vertical, 8)
        .padding(.horizontal, 130)
    }
    .tint(.csDesert)
    .buttonStyle(.borderedProminent)
    .shadow(radius: 8)
    .disabled(!isValidForm)
    .sheet(isPresented: $isShownConfirmationSheet) {
      CodeConfirmationView()
        .presentationDetents([.large])
        .presentationCornerRadius(25)
        .presentationDragIndicator(.visible)
    }
  }
  
  // MARK: Sign In Option
  private var signInOption: some View {
    Button {
      dismiss()
    } label: {
      HStack(spacing: 5) {
        Text("Already a member?")
          .font(.poppins(.regular, size: 13))
          .foregroundStyle(.gray)
        Text("Sign In")
          .font(.poppins(.bold, size: 15))
          .foregroundStyle(.white)
      }
      .shadow(radius: 8)
    }
  }
  
  // Data validation methods
  
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
