import SwiftUI
import PhotosUI

struct UploadArtView: View {
    @EnvironmentObject var viewModel: ArtPostViewModel
    @EnvironmentObject var authManager: AuthManager
    
    @State private var title = ""
    @State private var artist = ""
    @State private var description = ""
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImage: Image?
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            Text("Upload Your Art")
                .font(.largeTitle)
                .fontWeight(.bold)

            if let selectedImage {
                selectedImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .cornerRadius(10)
            } else {
                Image(systemName: "photo.on.rectangle.angled")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.gray.opacity(0.5))
            }

            PhotosPicker("Select Image", selection: $selectedItem, matching: .images)
                .buttonStyle(.borderedProminent)

            TextField("Enter title", text: $title)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("Enter artist name", text: $artist)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("Enter description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button(action: uploadPost) {
                Text("Upload Post")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .disabled(selectedImage == nil || title.isEmpty || artist.isEmpty || description.isEmpty || authManager.isGuest)

        }
        .onChange(of: selectedItem) {
            Task {
                if let data = try? await selectedItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = Image(uiImage: uiImage)
                }
            }
        }
    }
    
    func uploadPost() {
        // For now, use ArtPostViewModel.testUserID as the owner
        viewModel.addPost(imageName: "photo.artframe", title: title, artist: artist, ownerID: ArtPostViewModel.testUserID, description: description)
        clearFields()
    }
    
    func clearFields() {
        title = ""
        artist = ""
        description = ""
        selectedImage = nil
        selectedItem = nil
    }
}

struct UploadArtView_Previews: PreviewProvider {
    static var previews: some View {
        UploadArtView()
            .environmentObject(ArtPostViewModel())
            .environmentObject(AuthManager())
    }
} 