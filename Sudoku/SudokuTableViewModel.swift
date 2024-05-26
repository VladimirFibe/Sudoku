import SwiftUI

class SudokuTableViewModel: ObservableObject {
    var table: [Sudoku] { brain.table }
    @Published var digits: [DigitButton] = [.init(id: 7), .init(id: 8), .init(id: 9), .init(id: 4), .init(id: 5), .init(id: 6), .init(id: 1), .init(id: 2), .init(id: 3)]
    @Published var brain = SudokuBrain()
    var selected: Int { brain.selected }
    var lines: Set<Int> { brain.lines}

    func backgroundColor(index: Int) -> Color {
        lines.contains(index) ? Color.selected : Color.white
    }

    func buttonTapped(_ value: Int) {
        brain.setValue(value)
    }

    func gameTapped(_ index: Int) {
        brain.selected = index
    }

    func gameDoubleTapped(_ index: Int) {
        brain.flipCard(index)
    }
}

struct DigitButton: Identifiable {
    var id: Int

    var text: String { "\(id)"}
}
