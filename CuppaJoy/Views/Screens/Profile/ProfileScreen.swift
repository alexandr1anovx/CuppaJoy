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
  @State private var isShownData = false
  @FocusState private var fieldContent: TextFieldContentType?
  
  let context = CIContext()
  let filter = CIFilter.qrCodeGenerator()
  
  // MARK: Main Body
  var body: some View {
    ZStack {
      Color.csBlack.ignoresSafeArea(.all)
      VStack(spacing: 20) {
        textFieldList
        cityPicker.padding(.horizontal, 25)
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
  
  // MARK: TextFields
  private var textFieldList: some View {
    List {
      CSTextField(for: .username, inputData: $username)
        .focused($fieldContent, equals: .username)
        .textInputAutocapitalization(.words)
        .submitLabel(.next)
        .textInputAutocapitalization(.words)
        .onSubmit { fieldContent = .phoneNumber }
      CSTextField(for: .phoneNumber, inputData: $phoneNumber)
        .focused($fieldContent, equals: .phoneNumber)
        .blur(radius: isShownData ? 0 : 2)
        .submitLabel(.next)
        .onSubmit { fieldContent = .emailAddress }
      
      CSTextField(for: .emailAddress, inputData: $emailAddress)
        .focused($fieldContent, equals: .emailAddress)
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .blur(radius: isShownData ? 0 : 2)
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
    HStack(spacing: 0) {
      Text("City:")
        .font(.callout)
        .fontWeight(.semibold)
        .foregroundStyle(.gray)
      Picker("City", selection: $selectedCity) {
        ForEach(City.allCases, id: \.self) { city in
          Text(city.title)
        }
      }
      Spacer()
      showDataButton
    }
  }
  
  // MARK: Button "Show/Hide Data"
  private var showDataButton: some View {
    Button {
      isShownData.toggle()
    } label: {
      Text(isShownData ? "Hide Data" : "Show Data")
        .font(.callout)
        .fontWeight(.semibold)
        .foregroundStyle(.white)
        .padding(.horizontal, 13)
        .padding(.vertical, 12)
        .background(.black)
        .clipShape(.capsule)
    }
  }
  
  // MARK: QRCode
  private var qrcodeImage: some View {
    Image(uiImage: generateQRCode(from: username))
      .resizable()
      .interpolation(.none)
      .frame(width: 200, height: 200)
  }
  
  
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
