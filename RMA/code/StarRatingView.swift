import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int

    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { number in
                Button(action: {
                    self.rating = number
                }) {
                    Image(systemName: number > self.rating ? "star" : "star.fill")
                        .foregroundColor(.yellow)
                }
            }
        }
    }
} 