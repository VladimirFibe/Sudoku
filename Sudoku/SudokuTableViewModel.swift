import SwiftUI

class SudokuTableViewModel: ObservableObject {
    @Published var table: [Sudoku] = []
    @Published var digits: [DigitButton] = [.init(id: 7), .init(id: 8), .init(id: 9), .init(id: 4), .init(id: 5), .init(id: 6), .init(id: 1), .init(id: 2), .init(id: 3)]
    let sample = [  0, 6, 0,    0, 0, 2,    0, 0, 0,
                    0, 0, 3,    0, 0, 0,    0, 0, 1,
                    4, 0, 0,    8, 6, 0,    0, 9, 0,

                    5, 0, 0,    0, 0, 7,    0, 0, 0,
                    0, 1, 0,    2, 5, 0,    0, 0, 9,
                    0, 0, 0,    0, 0, 4,    0, 2, 0,

                    6, 0, 0,    5, 9, 0,    0, 8, 0,
                    0, 0, 0,    0, 7, 0,    0, 0, 0,
                    0, 4, 0,    0, 0, 0,    6, 0, 0]
    @Published var brain = SudokuBrain()
    var selected: Int { brain.selected }
    var lines: Set<Int> { brain.lines}

    func backgroundColor(index: Int) -> Color {
        lines.contains(index) ? Color.selected : Color.white
    }
    
    init() {
        for i in 0..<81 {
            let sudoku = Sudoku(id: i, value: sample[i])
            table.append(sudoku)
        }
    }

    func buttonTapped(_ index: Int) {
        brain.selected = index
    }
}

struct DigitButton: Identifiable {
    var id: Int

    var text: String { "\(id)"}
}
