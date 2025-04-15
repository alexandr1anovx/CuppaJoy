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
  @EnvironmentObject var authViewModel: AuthViewModel
  
  @State private var fullName = ""
  @State private var email = ""
  @State private var accountPassword = ""
  @State private var selectedCity: City = .mykolaiv
  @State private var isShownDeleteAccountAlert = false
  @State private var isShownSavedChangesAlert = false
  
  @FocusState var inputContent: InputContentType?
  @Binding var isShownTabBar: Bool
  @Binding var generalScreenPath: NavigationPath
  let generator = UINotificationFeedbackGenerator()
  
  var hasChanges: Bool {
    guard let currentUser = authViewModel.currentUser else {
      print("Cannot get current user for checking changes.")
      return false
    }
    let changedFullName = fullName != currentUser.fullName
    let changedEmail = email != currentUser.emailAddress
    let changedCity = selectedCity.title != currentUser.city
    
    return changedFullName || changedEmail || changedCity
  }
  
  var isValidForm: Bool {
    authViewModel.isValid(fullName: fullName) &&
    (email == authViewModel.currentUser?.emailAddress || authViewModel.isValid(email: email))
  }
  
  struct InputFieldsList: View {
    @FocusState var inputContent: InputContentType?
    var body: some View {
      Text("Hi")
    }
  }
  
  var body: some View {
    ZStack {
      Color.csBlack
        .ignoresSafeArea(.all)
        .onTapGesture {
          UIApplication.shared.hideKeyboard()
        }
      ScrollView {
        VStack(spacing:0) {
          EditableProfileImageView()
          personalDataList
          HStack {
            deleteAccountButton
            Spacer()
            saveChangesButton
          }
          .padding(.top,20)
          .padding(.horizontal,23)
        }
        .padding(.top, 10)
      }
    }
    // Alert that appears when the user wants to delete an account.
    .alert("Account Deletion", isPresented: $isShownDeleteAccountAlert) {
      SecureField("Your password", text: $accountPassword)
      Button("Cancel", role: .cancel) { accountPassword = "" }
      Button("Delete", role: .destructive) {
        Task {
          try await authViewModel.deleteUser(with: accountPassword)
          accountPassword = ""
        }
      }
    } message: {
      Text("Are you sure you want to delete your account? It will delete all your data forever.")
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
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          isShownTabBar = true
          generalScreenPath.removeLast()
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
          .submitLabel(.next)
          .textInputAutocapitalization(.words)
          .onSubmit { inputContent = .email }
        
        Button("Edit") {
          inputContent = .fullName
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
      }
      .buttonStyle(.plain)
      
      HStack {
        InputField(for: .email, data: $email)
          .focused($inputContent, equals: .email)
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .submitLabel(.done)
          .onSubmit { inputContent = nil }
        
        Button("Edit") {
          inputContent = .email
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
      }
      .buttonStyle(.plain)
      
      HStack(spacing: 15) {
        Image(systemName: "building.2.fill")
          .frame(width: 18, height: 18)
          .foregroundStyle(.csCream)
          .opacity(0.8)
        Picker("City:", selection: $selectedCity) {
          ForEach(City.allCases) { city in
            Text(city.title)
          }
        }
        .font(.subheadline)
        .foregroundStyle(.primary)
      }
    }
    .listRowSpacing(10)
    .environment(\.defaultMinListRowHeight, 50)
    .frame(height: 210)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
    .shadow(radius: 1)
  }
  
  private var saveChangesButton: some View {
    Button {
      generator.notificationOccurred(.success)
      Task {
        await authViewModel.updateProfile(
          fullName: fullName,
          email: email,
          city: selectedCity
        )
      }
    } label: {
      Text("Save Changes")
        .font(.subheadline)
        .foregroundStyle(.blue)
    }
    .disabled(!hasChanges || !isValidForm)
    .opacity(!hasChanges || !isValidForm ? 0 : 1)
  }
  
  private var deleteAccountButton: some View {
    Button {
      isShownDeleteAccountAlert.toggle()
      generator.notificationOccurred(.error)
    } label: {
      Text("Delete Account")
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.red)
        .opacity(0.8)
        .underline()
    }
  }
  
  private func loadUserData() {
    guard let currentUser = authViewModel.currentUser else {
      print("Cannot retrieve current user data.")
      return
    }
    fullName = currentUser.fullName
    email = currentUser.emailAddress
  }
}

#Preview {
  ProfileScreen(
    isShownTabBar: .constant(false),
    generalScreenPath: .constant(NavigationPath())
  )
  .environmentObject(AuthViewModel.previewMode())
}
