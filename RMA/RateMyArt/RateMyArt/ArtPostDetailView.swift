import SwiftUI

struct ArtPostDetailView: View {
    let post: ArtPost
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Art Post Detail View")
                .font(.largeTitle)
                .padding()
            Text("Post title: \(post.title)")
            // Add more details as needed
            Spacer()
        }
        .padding()
    }
}

// Preview (requires a mock ArtPost)
struct ArtPostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArtPostDetailView(post: ArtPost(imageName: <#T##String#>, title: <#T##String#>, artist: <#T##String#>, ownerID: <#T##UUID#>, description: <#T##String#>))
    }
}
