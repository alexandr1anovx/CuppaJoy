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
  @State private var email = ""
  @FocusState private var fieldContent: AuthFieldContent?
  @State private var selectedCity = City.mykolaiv
  @State private var isShownData = false
  
  let context = CIContext()
  let filter = CIFilter.qrCodeGenerator()
  
  // MARK: View
  var body: some View {
    ZStack {
      Color.csBlack.ignoresSafeArea(.all)
      VStack(spacing: 20) {
        textFieldList
        selectedCityPicker.padding(.horizontal,25)
        Spacer()
        qrcodeImage
        Spacer()
      }
    }
    .navigationTitle("My Profile")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        ReturnButton()
      }
    }
  }
  
  // MARK: Text Field
  private var textFieldList: some View {
    List {
      CSTextField(
        icon: "person",
        prompt: "Alexander Pushkin",
        inputData: $username
      )
      .focused($fieldContent, equals: .username)
      .textInputAutocapitalization(.words)
      .submitLabel(.next)
      .textInputAutocapitalization(.words)
      .onSubmit { fieldContent = .phoneNumber }
      
      CSTextField(
        icon: "phone",
        prompt: "Phone number",
        inputData: $phoneNumber
      )
      .focused($fieldContent, equals: .phoneNumber)
      .submitLabel(.next)
      .onSubmit { fieldContent = .email }
      .blur(radius: isShownData ? 0:2)
      
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
      .blur(radius: isShownData ? 0:2)
    }
    .frame(height: 185)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
  }
  
  // MARK: City Picker
  private var selectedCityPicker: some View {
    HStack(spacing: 0) {
      Text("City:")
        .font(.callout)
        .fontDesign(.monospaced)
        .foregroundStyle(.gray)
      Picker("City", selection: $selectedCity) {
        ForEach(City.allCases, id: \.self) { city in
          Text(city.rawValue)
        }
      }
      .pickerStyle(.menu)
      Spacer()
      showDataButton
    }
  }
  
  // MARK: Blur Button
  private var showDataButton: some View {
    Button {
      isShownData.toggle()
    } label: {
      Text(isShownData ? "Hide Data" : "Show Data")
        .font(.callout)
        .fontDesign(.monospaced)
        .foregroundStyle(.csCream)
        .padding(.horizontal, 13)
        .padding(.vertical, 12)
        .background(.csDarkGrey)
        .clipShape(.capsule)
    }
  }
  
  // MARK: QR code
  private var qrcodeImage: some View {
    Image(uiImage: generateQRCode(from: username))
      .resizable()
      .interpolation(.none)
      .frame(width: 200, height: 200)
  }
  
  // MARK: QR code generation method
  private func generateQRCode(from string: String) -> UIImage {
    filter.message = Data(string.utf8)
    if let outputImage = filter.outputImage,
       let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
      return UIImage(cgImage: cgImage)
    }
    return UIImage()
  }
}

#Preview {
  ProfileScreen()
}
