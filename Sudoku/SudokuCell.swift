import SwiftUI

struct SudokuCell: View {
    let sudoku: Sudoku
    let selectedDigit: Int
    var body: some View {
        VStack {
            if sudoku.value == 0 {
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 3), spacing: 0) {
                    ForEach(1...9, id: \.self) { digit in
                        Text("\(digit)")
                            .font(.system(size: 10, weight: selectedDigit == digit ? .black : .regular))
                            .foregroundStyle(selectedDigit == digit ? Color(.label) : Color(.secondaryLabel))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .opacity(sudoku.notes.contains(digit) ? 1 : 0)

                    }

                }
                .padding(2)
            } else {
                Text(sudoku.text)
                    .font(.system(size: 24, weight: selectedDigit == sudoku.value ? .bold : .regular))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .aspectRatio(1, contentMode: .fit)
            }
        }
    }
}

#Preview {
    SudokuCell(sudoku: Sudoku(id: 0, isOrigin: false, value: 0, notes: [1, 2 ,3, 4, 5, 8, 9]), selectedDigit: 4)
        .padding(100)
}
