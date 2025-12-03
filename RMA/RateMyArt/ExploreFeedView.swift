import SwiftUI

struct ExploreFeedView: View {
    @EnvironmentObject var viewModel: ArtPostViewModel
    @EnvironmentObject var authManager: AuthManager
    @State private var showingSuggestions = false
    @State private var selectedPost: ArtPost? = nil

    var body: some View {
        NavigationView {
            List(viewModel.posts.indices, id: \.self) { index in
                Button(action: {
                    selectedPost = viewModel.posts[index]
                }) {
                    VStack(alignment: .leading, spacing: 10) {
                        Image(systemName: viewModel.posts[index].imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .foregroundColor(.primary)
                        Text(viewModel.posts[index].title)
                            .font(.headline)
                        Text("by \(viewModel.posts[index].artist)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        StarRatingView(rating: $viewModel.posts[index].rating)
                    }
                    .padding(.vertical)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .listStyle(.plain)
                .navigationTitle("Explore")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingSuggestions = true }) {
                        Image(systemName: "wand.and.stars")
                    }
                }
            }
            .sheet(isPresented: $showingSuggestions) {
                SuggestionsView()
            }
            .sheet(item: $selectedPost) { post in
                ArtPostDetailView(post: post)
                    .environmentObject(viewModel)
            }
        }
    }
}

struct ExploreFeedView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreFeedView()
            .environmentObject(ArtPostViewModel())
            .environmentObject(AuthManager())
    }
} 