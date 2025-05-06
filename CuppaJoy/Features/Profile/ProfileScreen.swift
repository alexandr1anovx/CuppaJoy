//
//  ProfileScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.10.2024.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ProfileScreen: View {
  
  // MARK: Stored Properties
  @Binding var path: NavigationPath
  @Binding var isShownTabBar: Bool
  @EnvironmentObject var authViewModel: AuthViewModel
  @State private var fullName = ""
  @State private var email = ""
  @State private var accountPassword = ""
  @State private var selectedCity: City = .mykolaiv
  @State private var isShownDeleteAccountAlert = false
  @State private var isShownSavedChangesAlert = false
  @FocusState var inputContent: InputContentType?
  
  let feedbackGenerator = UINotificationFeedbackGenerator()
  private let validationService = ValidationService.shared

  // MARK: Computed Properties
  private var hasChanges: Bool {
    guard let currentUser = authViewModel.currentUser else {
      print("Cannot get current user for checking changes.")
      return false
    }
    let changedFullName = fullName != currentUser.fullName
    let changedEmail = email != currentUser.emailAddress
    let changedCity = selectedCity.title != currentUser.city
    
    return changedFullName || changedEmail || changedCity
  }
  
  private var isValidForm: Bool {
    validationService.isValid(fullName: fullName) &&
    (email == authViewModel.currentUser?.emailAddress || validationService.isValid(email: email))
  }
  
  // MARK: Body
  var body: some View {
    ZStack {
      Color.appBackgroundDimmed.ignoresSafeArea(.all)
      ScrollView {
        VStack {
          EditableProfileImageView()
          personalDataList
          HStack {
            deleteAccountButton
            Spacer()
            saveChangesButton
          }
          .padding(.horizontal,23)
          .padding(.top,15)
        }
      }
    }
    // Alert that appears when the user wants to delete an account.
    .alert("Account Deletion", isPresented: $isShownDeleteAccountAlert) {
      SecureField("Your password", text: $accountPassword)
      Button("Cancel", role: .cancel) { accountPassword = "" }
      Button("Delete", role: .destructive) {
        Task {
          await authViewModel.deleteUser(withPassword: accountPassword)
        }
      }
    } message: {
      Text("Are you sure? It will delete all your data forever.")
    }
    // Alert that appears when the user changes personal data.
    .alert(item: $authViewModel.alertItem) { alertItem in
      Alert(
        title: alertItem.title,
        message: alertItem.message,
        dismissButton: alertItem.dismissButton
      )
    }
    .onAppear {
      isShownTabBar = false
      loadUserData()
    }
    .navigationTitle("Profile")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button {
          path.removeLast()
        } label: {
          ReturnButtonLabel()
        }
      }
    }
  }
  
  private var personalDataList: some View {
    List {
      HStack {
        InputField(for: .fullName, data: $fullName)
          .focused($inputContent, equals: .fullName)
          .textInputAutocapitalization(.words)
        Button("Edit") { inputContent = .fullName }
          .font(.subheadline)
          .foregroundStyle(.gray)
      }
      .buttonStyle(.plain)
      
      HStack {
        InputField(for: .email, data: $email)
          .focused($inputContent, equals: .email)
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
        Button("Edit") { inputContent = .email }
          .font(.subheadline)
          .foregroundStyle(.gray)
      }
      .buttonStyle(.plain)
      
      HStack {
        Image(systemName: "building.2.crop.circle.fill")
          .foregroundStyle(.csCream)
        Picker("City:", selection: $selectedCity) {
          ForEach(City.allCases) { city in
            Text(city.title)
          }
        }
        .font(.subheadline)
        .foregroundStyle(.primary)
      }
    }
    .frame(height: 205)
    .customListStyle(rowSpacing: 10, shadowRadius: 1)
    .environment(\.defaultMinListRowHeight, 50)
    .scrollDisabled(true)
  }
  
  private var saveChangesButton: some View {
    Button("Save Changes") {
      Task {
        await authViewModel.updateProfile(
          fullName: fullName,
          email: email,
          city: selectedCity
        )
        feedbackGenerator.notificationOccurred(.success)
      }
    }
    .font(.subheadline)
    .foregroundStyle(.blue)
    .buttonStyle(.bordered)
    .disabled(!hasChanges || !isValidForm)
    .opacity(!hasChanges || !isValidForm ? 0:1)
  }
  
  private var deleteAccountButton: some View {
    Button {
      isShownDeleteAccountAlert.toggle()
      feedbackGenerator.notificationOccurred(.error)
    } label: {
      Text("Delete Account")
        .font(.footnote)
        .foregroundStyle(.gray)
        .underline()
    }
  }
  
  private func loadUserData() {
    guard let currentUser = authViewModel.currentUser else {
      print("Cannot retrieve current user data at profile screen.")
      return
    }
    fullName = currentUser.fullName
    email = currentUser.emailAddress
  }
}

#Preview {
  ProfileScreen(
    path: .constant(NavigationPath()),
    isShownTabBar: .constant(false)
  )
  .environmentObject(AuthViewModel.previewMode())
}
