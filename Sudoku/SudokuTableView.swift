import SwiftUI

struct SudokuTableView: View {
    @StateObject var viewModel = SudokuTableViewModel()
    var columns = Array(repeating: GridItem(spacing: 0), count: 9)

    var body: some View {
        VStack(spacing: 20) {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(viewModel.table) { sudoku in
                    SudokuCell(sudoku: sudoku)
                        .background(viewModel.backgroundColor(index: sudoku.id))
                        .onTapGesture {
                            viewModel.buttonTapped(sudoku.id)
                        }
                }
            }
            .padding(4)
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 10), count: 3)) {
                ForEach(viewModel.digits) { digit in
                    Button(action: {

                    }) {
                        Text(digit.text)
                            .font(.system(size: 24))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .clipShape(Circle())
                            .overlay {
                                Circle().stroke()
                            }
                    }
                }

            }
            .padding(.horizontal, 100)
            Spacer()
        }
    }
}

#Preview {
    SudokuTableView()
}
