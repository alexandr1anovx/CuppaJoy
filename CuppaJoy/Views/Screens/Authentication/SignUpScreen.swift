//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

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
  @Environment(\.dismiss) var dismiss
  
  // Picker customization settings
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
        VStack(alignment: .center, spacing:0) {
          AuthHeaderView(
            title: "Sign Up.",
            subtitle: "Let's create an account."
          )
          textFieldList
          cityPicker
            .padding(22)
          signUpButton
            .padding(.top,25)
          signInOption
            .padding(.top,20)
          Spacer()
        }
        .padding(.top,20)
        .sheet(isPresented: $isShownConfirmationSheet) {
          CodeConfirmationView()
            .presentationDetents([.large])
            .presentationCornerRadius(25)
            .presentationDragIndicator(.visible)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
          ToolbarItem(placement: .topBarLeading) {
            ReturnButton()
          }
        }
      }
      .scrollIndicators(.hidden)
    }
  }
  // MARK: - Text Field list
  private var textFieldList: some View {
    List {
      CustomTextField(
        imageName: "document",
        placeholder: "Alexander Pushkin",
        inputData: $initials
      )
      CustomTextField(
        imageName: "phone",
        placeholder: "Enter your phone number",
        inputData: $phoneNumber
      )
      CustomTextField(
        imageName: "envelope",
        placeholder: "user@example.com",
        inputData: $email
      )
    }
    .frame(height: 185)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
  }
  // MARK: - City Picker
  private var cityPicker: some View {
    Picker("City", selection: $selectedCity) {
      ForEach(City.allCases, id: \.self) { city in
        Text(city.rawValue)
      }
    }
    .pickerStyle(.segmented)
  }
  
  // MARK: - Sign Up button
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
    .tint(Color.csBrown)
    .buttonStyle(.borderedProminent)
    .shadow(radius: 5)
  }
  
  // MARK: - Sign In option
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
}

#Preview {
  SignUpScreen()
}
