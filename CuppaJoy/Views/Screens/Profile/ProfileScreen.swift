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
  @FocusState private var fieldContent: TextFieldInputType?
  
  @EnvironmentObject var authViewModel: AuthViewModel
  
  let context = CIContext()
  let filter = CIFilter.qrCodeGenerator()
  
  // MARK: Body
  var body: some View {
    ZStack {
      Color.csBlack.ignoresSafeArea(.all)
      
      VStack(spacing: 0) {
        // Avatar
        ProfileImageView()
        // Personal Data
        personalDataList
        // Buttons
        HStack{
          showDataButton
          Spacer()
          saveDataButton
        }
        .padding(.top,15)
        .padding(.horizontal,23)
        Spacer()
      }
      .padding(.top)
    }
    .navigationTitle("Profile")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  // MARK: Personal Data List
  private var personalDataList: some View {
    List {
      HStack {
        DefaultTextField(for: .fullName, inputData: $username)
          .focused($fieldContent, equals: .fullName)
          .textInputAutocapitalization(.words)
          .submitLabel(.next)
          .textInputAutocapitalization(.words)
          .blur(radius: isShownData ? 0 : 2)
          .onSubmit { fieldContent = .emailAddress }
        
        Button("Edit") {
          fieldContent = .fullName
        }
        .disabled(!isShownData)
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
      }
      .buttonStyle(.plain)
      
      HStack {
        DefaultTextField(for: .emailAddress, inputData: $emailAddress)
          .focused($fieldContent, equals: .emailAddress)
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .blur(radius: isShownData ? 0 : 2)
          .submitLabel(.done)
          .onSubmit { fieldContent = nil }
        
        Button("Edit") {
          fieldContent = .emailAddress
        }
        .disabled(!isShownData)
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
          ForEach(City.allCases, id: \.self) { city in
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
  }
  
  // MARK: Save Data Button
  private var saveDataButton: some View {
    Button {
      // show an alert
    } label: {
      Text("Save Data")
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.white)
        .padding(13)
        .background(.black)
        .clipShape(.capsule)
    }
  }
  
  // MARK: Button "Show/Hide Data"
  private var showDataButton: some View {
    Button {
      isShownData.toggle()
      fieldContent = nil
    } label: {
      Text(isShownData ? "Hide Data" : "Show Data")
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.white)
        .padding(13)
        .background(.black)
        .clipShape(.capsule)
    }
  }
  
  /*
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
  */
}

#Preview {
  ProfileScreen()
}
