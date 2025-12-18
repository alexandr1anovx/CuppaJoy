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
  
  @Binding var path: NavigationPath
  @Binding var isShownTabBar: Bool
  @StateObject var viewModel: ProfileViewModel
  @FocusState var inputContent: InputContentType?
  private let feedbackGenerator = UINotificationFeedbackGenerator()
  
  var body: some View {
    ZStack {
      Color.appBackgroundDimmed.ignoresSafeArea()
      ScrollView {
        VStack {
          EditableProfileImageView()
          personalDataList
          HStack {
            deleteAccountButton
            Spacer()
            saveChangesButton
          }
          .padding(.horizontal, 23)
          .padding(.top, 15)
        }
      }
    }
    .alert(item: $viewModel.alert) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
    .onAppear {
      isShownTabBar = false
      viewModel.loadUserData()
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
  
  // MARK: - Subviews
  
  private var personalDataList: some View {
    Form {
      HStack {
        InputField(for: .fullName, data: $viewModel.fullName)
          .focused($inputContent, equals: .fullName)
          .textInputAutocapitalization(.words)
        Button("Edit") { inputContent = .fullName }
          .font(.subheadline)
          .foregroundStyle(.gray)
      }
      .buttonStyle(.plain)
      
      HStack {
        InputField(for: .email, data: $viewModel.email)
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
        Picker("City:", selection: $viewModel.selectedCity) {
          ForEach(City.allCases) { city in
            Text(city.rawValue)
          }
        }
        .font(.subheadline)
        .foregroundStyle(.primary)
      }
    }
    .customListStyle(minRowHeight: 50, rowSpacing: 10, scrollDisabled: true, height: 205, shadow: 1)
  }
  
  private var saveChangesButton: some View {
    Button("Save Changes") {
      Task {
        await viewModel.saveChanges()
        feedbackGenerator.notificationOccurred(.success)
      }
    }
    .font(.subheadline)
    .foregroundStyle(.accent)
    .buttonStyle(.bordered)
    .disabled(!viewModel.formHasChanges || !viewModel.isValidForm)
    .opacity(!viewModel.formHasChanges || !viewModel.isValidForm ? 0:1)
  }
  
  private var deleteAccountButton: some View {
    Button {
      viewModel.isShownDeleteAccountAlert.toggle()
      feedbackGenerator.notificationOccurred(.error)
    } label: {
      Text("Delete Account")
        .font(.footnote)
        .foregroundStyle(.gray)
        .underline()
    }
    .alert("Account Deletion", isPresented: $viewModel.isShownDeleteAccountAlert) {
      SecureField("Your password", text: $viewModel.deletionPassword)
      Button("Cancel", role: .cancel) { viewModel.deletionPassword = "" }
      Button("Delete", role: .destructive) {}
    } message: {
      Text("Are you sure? It will delete all your data forever.")
    }
  }
}
