//
//  ProfileImageEditorView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 31.03.2025.
//

import SwiftUI
import PhotosUI

struct ProfileImageEditorView: View {
  
  let selectedImage: UIImage?
  
  @Binding var scale: CGFloat
  @Binding var offset: CGSize
  @State private var lastScale: CGFloat = 1.0
  @State private var lastOffset: CGSize = .zero
  @State private var showImagePicker = true
  
  @Binding var profileImage: UIImage?
  @Environment(\.dismiss) var dismiss
  
  let circleDiameter: CGFloat = 300
  
  init(
    _ profileImage: Binding<UIImage?>,
    selectedImage: UIImage?,
    scale: Binding<CGFloat>,
    offset: Binding<CGSize>
  ) {
    self.selectedImage = selectedImage
    _profileImage = profileImage
    _scale = scale
    _offset = offset
  }
  
  var body: some View {
    ZStack {
      Color.black.ignoresSafeArea()
      Color.black.opacity(0.4)
        .ignoresSafeArea()
        .overlay {
          Circle()
            .frame(width: circleDiameter, height: circleDiameter)
            .blendMode(.destinationOut)
        }
        .compositingGroup()
        .background {
          if let selectedImage = selectedImage {
            Image(uiImage: selectedImage)
              .resizable()
              .scaledToFill()
              .scaleEffect(scale)
              .offset(offset)
          }
        }
        .clipped()
      
      HStack {
        // Dismiss Button
        Button {
          dismiss()
        } label: {
          Text("Cancel")
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .padding(.vertical, 13)
            .padding(.horizontal, 20)
            .background(.red)
            .clipShape(.capsule)
            .shadow(color: .red, radius: 5)
        }
        Spacer()
        // Save Button
        Button {
          saveCroppedImage()
        } label: {
          Text("Save")
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.white)
            .padding(.vertical, 13)
            .padding(.horizontal, 20)
            .background(.black)
            .clipShape(.capsule)
            .shadow(color: .white, radius: 3)
        }
      }
      .padding()
      .padding(.bottom, 20)
      .frame(maxHeight: .infinity, alignment: .bottom)
    }
    .ignoresSafeArea()
    
    .gesture(
      // It is used for multiple gesture recognizers.
      SimultaneousGesture(
        DragGesture()
          .onChanged { value in
            let newOffset = CGSize(
              width: lastOffset.width + value.translation.width,
              height: lastOffset.height + value.translation.height
            )
            offset = clampedOffsetWithinScreen(for: newOffset)
          }
          .onEnded { _ in
            lastOffset = offset
          },
        
        // MARK: !!! Replace with the MagnifyGesture later
        MagnificationGesture()
          .onChanged { value in
            scale = lastScale * value
          }
          .onEnded { _ in
            lastScale = scale
            offset = clampedOffsetWithinScreen(for: offset)
            lastOffset = offset
          }
      )
    )
    .onAppear {
      scale = 1.0
      lastScale = 1.0
      offset = .zero
      lastOffset = .zero
    }
  }
  
  private func clampedOffsetWithinScreen(for proposedOffset: CGSize) -> CGSize {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    let maxX = screenWidth / 2
    let maxY = screenHeight / 2
    
    return CGSize(
      width: min(max(proposedOffset.width, -maxX), maxX),
      height: min(max(proposedOffset.height, -maxY), maxY)
    )
  }
  
  private func saveCroppedImage() {
    guard selectedImage != nil else { return }
    
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
    
    let cropRect = CGRect(
      x: (UIScreen.main.bounds.width - circleDiameter) / 2,
      y: (UIScreen.main.bounds.height - circleDiameter) / 2,
      width: circleDiameter,
      height: circleDiameter
    )
    
    let renderer = UIGraphicsImageRenderer(bounds: cropRect)
    
    profileImage = renderer.image { _ in
      window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
    }
    dismiss()
  }
}

// MARK: PhotosPickerItem Extension

extension PhotosPickerItem {
  func loadUIImage() async -> UIImage? {
    if let data = try? await loadTransferable(type: Data.self),
       let image = UIImage(data: data) {
      return image
    } else {
      return nil
    }
  }
}
