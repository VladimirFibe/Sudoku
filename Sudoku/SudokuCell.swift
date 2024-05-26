import SwiftUI

struct SudokuCell: View {
    let sudoku: Sudoku
    var body: some View {
        VStack {
            if sudoku.value == 0 {
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 3), spacing: 0) {
                    ForEach(1...9, id: \.self) { digit in
                        Text("\(digit)")
                            .font(.system(size: 10))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .opacity(sudoku.notes.contains(digit) ? 1 : 0)

                    }

                }
                .padding(2)
            } else {
                Text(sudoku.text)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(1, contentMode: .fit)
            }
        }

    }
}

#Preview {
    SudokuCell(sudoku: Sudoku(id: 0, isOrigin: false, value: 1))
        .padding(100)
}
