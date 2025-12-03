import SwiftUI

struct MainTabView: View {
    @StateObject private var artPostViewModel = ArtPostViewModel()

    var body: some View {
        TabView {
            ExploreFeedView()
                .environmentObject(artPostViewModel)
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }

            FriendsFeedView()
                .tabItem {
                    Label("Friends", systemImage: "person.2")
                }

            UploadArtView()
                .environmentObject(artPostViewModel)
                .tabItem {
                    Label("Upload", systemImage: "plus.circle.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}

struct User: Identifiable {
    let id = UUID()
    var name: String
    var profileImageName: String
    var tags: [String]
} 