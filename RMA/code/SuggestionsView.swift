import SwiftUI
import FirebaseCore

struct SuggestionsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Pick topics you want to see")
                .font(.title2)
                .padding()
            Text("(Suggestions UI coming soon)")
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
    }
}

struct SuggestionsView_Previews: PreviewProvider {
    static var previews: some View {
        SuggestionsView()
    }
} 
