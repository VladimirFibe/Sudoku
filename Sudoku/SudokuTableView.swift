import SwiftUI

struct SudokuTableView: View {
    @StateObject var viewModel = SudokuTableViewModel()
    var columns = Array(repeating: GridItem(spacing: 0), count: 9)

    var body: some View {
        VStack(spacing: 20) {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(viewModel.table) { sudoku in
                    VStack {
                        SudokuCell(sudoku: sudoku, selectedDigit: viewModel.selectedDigit)
                            .background(viewModel.backgroundColor(index: sudoku.id))
                            .onTapGesture {
                                viewModel.gameTapped(sudoku.id)
                            }
                    }
                    .highPriorityGesture(
                        TapGesture(count: 2)
                            .onEnded { _ in
                                viewModel.gameDoubleTapped(sudoku.id)
                            }
                    )
                }
            }
            .overlay(BackgroundView())
            LazyVGrid(columns: Array(repeating: GridItem(spacing: 16), count: 3), spacing: 16) {
                FuncButton(action: restart, image: "arrow.counterclockwise")
                FuncButton(action: erase, image: "eraser")
                FuncButton(action: {}, image: "info.circle")
                ForEach(viewModel.digits) { digit in
                    Button(action: {
                        viewModel.buttonTapped(digit.id)
                    }) {
                        Text(digit.text)
                            .font(.system(size: 24))
                            .frame(maxWidth: .infinity)
                            .frame(height: 44)
                            .clipShape(Capsule())
                            .overlay {
                                Capsule().stroke()
                            }
                    }
                    .disabled(viewModel.digitCount(digit.id) > 8)
                }

            }
            .padding(.horizontal, 12)
            Spacer()
        }
        .padding(4)
    }
    func restart() {
        viewModel.getSudoku()
    }

    func erase() {
        viewModel.erase()
    }
}

struct FuncButton: View {
    let action: () -> Void
    let image: String
    var body: some View {
        Button(action: action) {
            Image(systemName: image)
                .font(.system(size: 24))
                .frame(maxWidth: .infinity)
                .frame(height: 44)
                .clipShape(Capsule())
                .overlay {
                    Capsule().stroke()
                }
        }
    }
}

#Preview {
    SudokuTableView()
}
