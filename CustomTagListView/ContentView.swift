//
//  ContentView.swift
//  CustomTagListView
//
//  Created by Ian Talisic on 4/19/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TagSelectionView()
    }
}

#Preview {
    ContentView()
}

import SwiftUI

struct TagSelectionView: View {
    @State private var selectedTags: Set<String> = []
    @State private var tagRows: [[String]] = []
    
    let sampleTags = [
        "Swift", "Kotlin", "Flutter", "React Native", "Java", "Python",
        "C++", "Go", "Rust", "JavaScript", "Ruby", "Dart"
    ]

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(tagRows, id: \.self) { row in
                        HStack(spacing: 8) {
                            ForEach(row, id: \.self) { tag in
                                Text(tag)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .background(
                                        Capsule().fill(selectedTags.contains(tag) ?
                                            .indigo : Color.gray.opacity(0.3))
                                    )
                                    .foregroundColor(.white)
                                    .fixedSize()
                                    .scaleEffect(selectedTags.contains(tag) ? 0.90 : 1.0)
                                    .onTapGesture {
                                        toggleSelection(for: tag)
                                    }
                                    .animation(.spring(), value: selectedTags.contains(tag))
                            }
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                calculateRows(for: geometry.size.width)
            }
        }
    }
    
    private func toggleSelection(for tag: String) {
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
    }

    private func calculateRows(for totalWidth: CGFloat) {
        var rows: [[String]] = [[]]
        var currentRowWidth: CGFloat = 0
        let spacing: CGFloat = 8
        
        for tag in sampleTags {
            let tagWidth = tag.size(withAttributes: [.font: UIFont.systemFont(ofSize: 17)]).width + 24 + 24 // padding

            if currentRowWidth + tagWidth + spacing > totalWidth {
                rows.append([tag])
                currentRowWidth = tagWidth + spacing
            } else {
                rows[rows.count - 1].append(tag)
                currentRowWidth += tagWidth + spacing
            }
        }
        self.tagRows = rows
    }
}

struct TagSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TagSelectionView()
    }
}
