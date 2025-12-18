//
//  ProfileImageView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 31.03.2025.
//

import SwiftUI
import PhotosUI

struct EditableProfileImageView: View {
  
  @State private var profileImage: UIImage? = nil
  @State private var selectedImage: UIImage? = nil
  @State private var selectedPhotosPickerItem: PhotosPickerItem? = nil
  @State private var isShownConfirmationDialog = false
  @State private var isShownPhotoPicker = false
  @State private var isShownEditor = false
  @State private var editorOffset: CGSize = .zero
  @State private var editorScale: CGFloat = 1
  
  var body: some View {
    VStack(spacing: 30) {
      
      if let profileImage {
        Image(uiImage: profileImage)
          .resizable()
          .scaledToFill()
          .frame(width: UIConstants.Sizes.profileEditor, height: UIConstants.Sizes.profileEditor)
          .clipShape(.circle)
          .onTapGesture { isShownConfirmationDialog = true }
          .overlay(alignment: .bottomTrailing) {
            ZStack {
              Circle()
                .foregroundStyle(.black)
                .opacity(UIConstants.Opacity.profileImage)
                .frame(width: 30, height: 30)
              Image(systemName: "pencil")
            }
            .offset(x: -5, y: -5)
          }
      } else {
        Circle()
          .fill(Color.black)
          .frame(width: UIConstants.Sizes.profileEditor, height: UIConstants.Sizes.profileEditor)
          .overlay {
            VStack(spacing: 10) {
              Image(systemName: "plus.circle.fill")
                .font(.title3)
              Text("Add image")
                .font(.caption)
                .fontWeight(.medium)
            }
            .foregroundStyle(.white)
          }
          .onTapGesture { isShownPhotoPicker = true }
      }
    }
    .photosPicker(
      isPresented: $isShownPhotoPicker,
      selection: $selectedPhotosPickerItem
    )
    .confirmationDialog("Avatar", isPresented: $isShownConfirmationDialog) {
      Button("Edit Photo") { isShownEditor = true }
      Button("Choose new photo") {
        editorScale = 1
        editorOffset = .zero
        selectedPhotosPickerItem = nil
        isShownPhotoPicker = true
      }
    } // confirmation dialog
    .onChange(of: selectedPhotosPickerItem) { _, newValue in
      Task {
        if let newImage = await newValue?.loadUIImage() {
          selectedImage = newImage
        }
      }
    }
    .onChange(of: selectedImage) { _, newValue in
      guard newValue != nil else { return }
      isShownEditor = true
    }
    .fullScreenCover(isPresented: $isShownEditor) {
      ProfileImageEditorView(
        $profileImage,
        selectedImage: selectedImage,
        scale: $editorScale,
        offset: $editorOffset
      )
    }
  }
}
