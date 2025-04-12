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
  
  // MARK: Properties
  @State private var username = ""
  @State private var phoneNumber = ""
  @State private var emailAddress = ""
  @State private var selectedCity: City = .mykolaiv
  @FocusState private var fieldContent: InputContentType?
  
  @Binding var generalScreenPath: NavigationPath
  @Binding var isTabBarVisible: Bool
  
  @EnvironmentObject var authViewModel: AuthViewModel
  
  // MARK: Body
  var body: some View {
    ZStack {
      Color.csBlack.ignoresSafeArea(.all)
      
      ScrollView {
        VStack(spacing: 0) {
          
          EditableProfileImageView()
          personalDataList
          HStack {
            Button("Delete Account") {
              // delete account action
            }
            Spacer()
            Button("Save Changes") {
              // save changes action
            }
          }
          .foregroundStyle(.white)
          .buttonStyle(.bordered)
          .padding(23)
        }
      }
      .onTapGesture {
        UIApplication.shared.hideKeyboard()
      }
    }
    .onAppear { isTabBarVisible = false }
    .navigationTitle("Profile")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          isTabBarVisible = true
          generalScreenPath.removeLast()
        } label: {
          ButtonLabelReturn()
        }
      }
    }
  }
  
  // MARK: Personal Data List
  private var personalDataList: some View {
    List {
      HStack {
        InputField(for: .fullName, data: $username)
          .focused($fieldContent, equals: .fullName)
          .textInputAutocapitalization(.words)
          .submitLabel(.next)
          .textInputAutocapitalization(.words)
          .onSubmit { fieldContent = .email }
        
        Button("Edit") {
          fieldContent = .fullName
        }
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
      }
      .buttonStyle(.plain)
      
      HStack {
        InputField(for: .email, data: $emailAddress)
          .focused($fieldContent, equals: .email)
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .submitLabel(.done)
          .onSubmit { fieldContent = nil }
        
        Button("Edit") {
          fieldContent = .email
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
  
  // MARK: Save Data Button
  private var saveDataButton: some View {
    Button {
      // show an alert
    } label: {
      ButtonLabelShort(
        "Save Changes",
        textColor: .white,
        bgColor: .black
      )
    }
  }
  
  private var deleteAccountButton: some View {
    Button {
      // ...
    } label: {
      ButtonLabel(
        "Delete Account",
        textColor: .white,
        bgColor: .red
      )
    }
  }
}

#Preview {
  ProfileScreen(
    generalScreenPath: .constant(NavigationPath()),
    isTabBarVisible: .constant(false)
  )
}
