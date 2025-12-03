import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var artPostViewModel: ArtPostViewModel
    @State private var username: String = "Test User"
    @State private var bio: String = "Just a test user trying out this awesome app!"
    @State private var avatarURL: URL? = nil // Placeholder for avatar image
    @State private var selectedPost: ArtPost? = nil

    // For demo: use ArtPostViewModel.testUserID as the current user
    let currentUserID = ArtPostViewModel.testUserID

    var userPosts: [ArtPost] {
        artPostViewModel.posts.filter { $0.ownerID == currentUserID }
    }

    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                    .shadow(radius: 5)
                    .padding(.bottom, 20)

                Text(username.isEmpty ? "Username" : username)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)

                Text(bio.isEmpty ? "No bio yet." : bio)
                    .font(.body)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text("Your Posts")
                    .font(.headline)
                    .padding(.top)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(userPosts) { post in
                            ZStack(alignment: .topTrailing) {
                                Button(action: {
                                    selectedPost = post
                                }) {
                                    VStack {
                                        Image(post.imageName)
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 140, height: 140)
                                            .clipped()
                                        Text(post.title)
                                            .font(.caption)
                                            .lineLimit(1)
                                    }
                                }
                                .buttonStyle(PlainButtonStyle())
                                if post.ownerID == currentUserID {
                                    Button(action: {
                                        if let idx = artPostViewModel.posts.firstIndex(where: { $0.id == post.id }) {
                                            artPostViewModel.posts.remove(at: idx)
                                        }
                                    }) {
                                        Image(systemName: "trash.circle.fill")
                                            .foregroundColor(.red)
                                            .padding(6)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                Button(action: {
                    authManager.logout()
                }) {
                    Text("Log Out")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                .padding(.top, 30)

                Spacer()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Edit") {
                        print("Edit Profile Tapped")
                    }
                }
            }
        }
        .onAppear {
            // Add the test screenshot post if not already present
            if !artPostViewModel.posts.contains(where: { $0.imageName == "TestScreenshot" && $0.ownerID == currentUserID }) {
                artPostViewModel.addPost(imageName: "TestScreenshot", title: "Test Screenshot", artist: username, ownerID: currentUserID, description: "Test screenshot post.")
            }
        }
        .sheet(item: $selectedPost) { post in
            ArtPostDetailView(post: post)
                .environmentObject(artPostViewModel)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthManager())
            .environmentObject(ArtPostViewModel())
    }
} 