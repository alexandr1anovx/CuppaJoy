//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

enum AuthFieldContent: Hashable {
  case initials
  case phoneNumber
  case email
}

enum City: String, CaseIterable {
  case mykolaiv = "Mykolaiv"
  case odesa = "Odesa"
}

struct SignUpScreen: View {
  
  @State private var initials = ""
  @State private var phoneNumber = ""
  @State private var email = ""
  @State private var selectedCity = City.mykolaiv
  @State private var isShownConfirmationSheet = false
  @FocusState private var fieldContent: AuthFieldContent?
  @Environment(\.dismiss) var dismiss
  
  private var isValidSignUpForm: Bool {
    !initials.isEmpty && isValidEmail(email)
  }
  
  // MARK: Picker style customizations
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
          AuthHeaderView(title: "Sign Up.", subtitle: "Let's create an account.")
          textFieldList
          cityPicker.padding(20)
          signUpButton.padding(.top,25)
          signInOption.padding(.top,25)
          Spacer()
        }
        .padding(.top,20)
        .navigationBarBackButtonHidden(true)
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            ReturnButton()
          }
        }
      }
    }
    .scrollIndicators(.hidden)
    .onAppear { fieldContent = .initials }
  }
  
  // MARK: Text Field list
  private var textFieldList: some View {
    List {
      MyTextField(
        icon: "person",
        prompt: "Alexander Pushkin",
        inputData: $initials
      )
      .focused($fieldContent, equals: .initials)
      .textInputAutocapitalization(.words)
      .submitLabel(.next)
      .textInputAutocapitalization(.words)
      .onSubmit { fieldContent = .phoneNumber }
      
      MyTextField(
        icon: "phone",
        prompt: "Phone number",
        inputData: $phoneNumber
      )
      .focused($fieldContent, equals: .phoneNumber)
      .submitLabel(.next)
      .onSubmit { fieldContent = .email }
      
      MyTextField(
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
    }
  }
  
  // MARK: Sign Up button
  private var signUpButton: some View {
    Button {
      isShownConfirmationSheet.toggle()
    } label: {
      Text("Sign Up")
        .font(.poppins(.bold, size: 15))
        .foregroundStyle(.white)
        .padding(.vertical,8)
        .padding(.horizontal,140)
    }
    .tint(Color.csDesert.opacity(0.8))
    .buttonStyle(.borderedProminent)
    .shadow(radius: 5)
    .disabled(!isValidSignUpForm)
    .sheet(isPresented: $isShownConfirmationSheet) {
      CodeConfirmationView()
        .presentationDetents([.large])
        .presentationCornerRadius(25)
        .presentationDragIndicator(.visible)
    }
  }
  
  // MARK: Sign In option
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
          .foregroundStyle(.csDesert)
      }
      .shadow(radius: 5)
    }
  }
  
  // MARK: Data validation methods
  // Should be moved to the authentication view model in the future.
  
  private func isValidEmail(_ email: String) -> Bool {
    let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
    let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
    return emailPredicate.evaluate(with: email)
  }
}

#Preview {
  SignUpScreen()
}
