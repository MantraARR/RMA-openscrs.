import Foundation

struct Comment: Identifiable {
    let id = UUID()
    let userID: UUID
    let text: String
    let date: Date
}

struct ArtPost: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let artist: String
    let ownerID: UUID
    var description: String
    var comments: [Comment] = []
    var rating: Int = 1
    
    static let example = ArtPost(
        imageName: "exampleImage",
        title: "Sample Art",
        artist: "Sample Artist",
        ownerID: UUID(),
        description: "This is a sample art post.",
        comments: [],
        rating: 5
    )
} 