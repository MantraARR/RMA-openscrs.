import SwiftUI

struct TagPickerView: View {
    @Binding var selectedTags: [String]
    @State private var customTag: String = ""
    
    let popularTags: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Pick your favorite styles/tags:")
                .font(.headline)
            
            // Popular tags
            WrapHStack(tags: popularTags, selectedTags: $selectedTags)
            
            // Custom tag input
            HStack {
                TextField("Add your own tag", text: $customTag)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Add") {
                    let trimmed = customTag.trimmingCharacters(in: .whitespacesAndNewlines)
                    guard !trimmed.isEmpty, !selectedTags.contains(trimmed) else { return }
                    selectedTags.append(trimmed)
                    customTag = ""
                }
                .disabled(customTag.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            
            // Selected tags
            if !selectedTags.isEmpty {
                Text("Selected tags:")
                    .font(.subheadline)
                WrapHStack(tags: selectedTags, selectedTags: $selectedTags, removable: true)
            }
        }
        .padding(.vertical)
    }
}

// Helper view to wrap tags in a flexible row
struct WrapHStack: View {
    let tags: [String]
    @Binding var selectedTags: [String]
    var removable: Bool = false
    
    var body: some View {
        FlexibleView(data: tags, spacing: 8, alignment: .leading) { tag in
            HStack(spacing: 4) {
                Text(tag)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(selectedTags.contains(tag) ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
                    .foregroundColor(.primary)
                    .cornerRadius(16)
                if removable {
                    Button(action: {
                        if let idx = selectedTags.firstIndex(of: tag) {
                            selectedTags.remove(at: idx)
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.red)
                    }
                }
            }
            .padding(.vertical, 2)
            .onTapGesture {
                if !removable {
                    if selectedTags.contains(tag) {
                        selectedTags.removeAll { $0 == tag }
                    } else {
                        selectedTags.append(tag)
                    }
                }
            }
        }
    }
}

// FlexibleView arranges tags in a wrapped row
struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    
    @State private var totalHeight = CGFloat.zero
    
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
        .frame(height: totalHeight)
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: Alignment(horizontal: alignment, vertical: .top)) {
            ForEach(Array(data), id: \ .self) { item in
                content(item)
                    .padding([.horizontal, .vertical], 2)
                    .alignmentGuide(.leading, computeValue: { d in
                        if abs(width - d.width) > g.size.width {
                            width = 0
                            height -= d.height + spacing
                        }
                        let result = width
                        if item == data.last {
                            width = 0 // Last item
                        } else {
                            width -= d.width + spacing
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if item == data.last {
                            height = 0 // Last item
                        }
                        return result
                    })
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        GeometryReader { geometry in
            Color.clear
                .preference(key: ViewHeightKey.self, value: geometry.size.height)
        }
        .onPreferenceChange(ViewHeightKey.self) { value in
            binding.wrappedValue = value
        }
    }
}

private struct ViewHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
} 