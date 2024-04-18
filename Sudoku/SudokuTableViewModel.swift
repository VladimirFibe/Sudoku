import Foundation

class SudokuTableViewModel: ObservableObject {
    @Published var table: [Sudoku] = []
    init() {
        for i in 0..<81 {
            let sudoku = Sudoku(id: i, value: 7)
            table.append(sudoku)
        }
    }
}
