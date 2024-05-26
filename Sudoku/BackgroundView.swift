import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 3), spacing: 0) {
            ForEach(1...9, id: \.self) { digit in
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 3), spacing: 0) {
                    ForEach(1...9, id: \.self) { digit in
                        Rectangle().stroke(lineWidth: 0.5)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)

                    }

                }
                .border(Color(.label))

            }

        }
        .border(Color(.label))
    }
}

#Preview {
    BackgroundView()
}
