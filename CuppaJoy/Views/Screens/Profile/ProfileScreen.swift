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
  
  // MARK: - Properties
  @State private var isBlurred = true
  let context = CIContext()
  let filter = CIFilter.qrCodeGenerator()
  
  // MARK: - View
  var body: some View {
    ZStack {
      Color.mainGradientBackground.ignoresSafeArea()
      
      VStack(spacing: 25) {
        cell(img: .man, header: "Initials", data: "name and surname")
        cell(img: .mobile, header: "Phone number", data: "+380955302040")
        cell(img: .envelope, header: "Email", data: "address@gmail.com")
          .blur(radius: isBlurred ? 3:0)
        cell(img: .map, header: "Selected address", data: "address")
          .blur(radius: isBlurred ? 3:0)
        
        Button {
          isBlurred.toggle()
        } label: {
          Text(isBlurred ? "Show Data" : "Hide Data")
            .bold()
            .foregroundStyle(.blue)
        }
        .padding(.top)
        
        Spacer()
        qrcodeImage
        Spacer()
      }
      .padding(.top, 20)
      .padding(.horizontal)
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
  
  // MARK: - QRcode Image
  private var qrcodeImage: some View {
    Image(uiImage: generateQRCode(from: "Alexander Andrianov"))
      .resizable()
      .interpolation(.none)
      .frame(width: 200, height: 200)
  }
  
  // MARK: - Cell
  private func cell(img: ImageResource, header: String, data: String) -> some View {
    HStack(spacing: 15) {
      Image(img)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 20, height: 20)
        .foregroundStyle(.white.opacity(0.7))
        .padding(10)
        .background(Color.csBrown)
        .clipShape(.capsule)
        .shadow(radius: 5)
      VStack(alignment: .leading, spacing: 5) {
        Text(header)
          .font(.poppins(.medium, size: 13))
          .foregroundStyle(.gray)
        Text(data)
          .font(.poppins(.bold, size: 14))
          .foregroundStyle(.csCreamy)
      }
      Spacer()
      Image(systemName: "square.and.pencil")
        .font(.title3)
        .foregroundStyle(.gray)
        .onTapGesture {
          // changing selected cell data logic
        }
    }
  }
  
  // MARK: - QRcode generation method
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
