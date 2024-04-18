import SwiftUI

struct SudokuTableView: View {
    @StateObject var viewModel = SudokuTableViewModel()
    var columns = Array(repeating: GridItem(spacing: 0), count: 9)
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(viewModel.table) { sudoku in
                SudokuCell(sudoku: sudoku)
            }
        }
    }
}

#Preview {
    SudokuTableView()
}
