import SwiftUI

struct FriendsFeedView: View {
    var body: some View {
        NavigationView {
            Text("Friends Feed")
                .font(.largeTitle)
                .navigationTitle("Friends")
        }
    }
}

struct FriendsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsFeedView()
    }
} 