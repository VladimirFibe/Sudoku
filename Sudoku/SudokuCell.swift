import SwiftUI

struct SudokuCell: View {
    let sudoku: Sudoku
    var body: some View {
        Text(sudoku.text)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                Rectangle().stroke()
            }
    }
}

#Preview {
    SudokuCell(sudoku: Sudoku(id: 0, value: 1))
        .padding(100)
}
