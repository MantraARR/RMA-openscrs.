import Foundation

class ArtPostViewModel: ObservableObject {
    static let testUserID = UUID() // For testing
    @Published var posts: [ArtPost] = [
        ArtPost(imageName: "photo.artframe", title: "My First Masterpiece", artist: "Creative User", ownerID: testUserID, description: "This is my first masterpiece!"),
        ArtPost(imageName: "paintpalette", title: "Colors of the Wind", artist: "ArtLover22", ownerID: UUID(), description: "A colorful journey through imagination."),
        ArtPost(imageName: "scribble.variable", title: "Abstract Thoughts", artist: "The Thinker", ownerID: UUID(), description: "Abstract art that makes you think.")
    ]

    func addPost(imageName: String, title: String, artist: String, ownerID: UUID, description: String) {
        let newPost = ArtPost(imageName: imageName, title: title, artist: artist, ownerID: ownerID, description: description)
        posts.insert(newPost, at: 0)
    }

    func addComment(to postID: UUID, comment: Comment) {
        if let idx = posts.firstIndex(where: { $0.id == postID }) {
            posts[idx].comments.append(comment)
        }
    }
} 