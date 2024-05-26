import SwiftUI

class SudokuTableViewModel: ObservableObject {
    var table: [Sudoku] { brain.table }
    @Published var digits: [DigitButton] = [.init(id: 7), .init(id: 8), .init(id: 9), .init(id: 4), .init(id: 5), .init(id: 6), .init(id: 1), .init(id: 2), .init(id: 3)]
    @Published var brain = SudokuBrain()
    var selected: Int { brain.selected }
    var selectedDigit: Int { brain.selectedDigit }
    var lines: Set<Int> { brain.lines}

    func backgroundColor(index: Int) -> Color {
        index == brain.selected ? Color.selectedCell :
        lines.contains(index) ? Color.selected : Color(.systemBackground)
    }

    func buttonTapped(_ value: Int) {
        brain.setValue(value)
    }

    func cellFont(_ index: Int) -> Font {
        selectedDigit == index ? Font.system(size: 24, weight: .bold) : Font.system(size: 24)
    }

    func gameTapped(_ index: Int) {
        brain.selected = index
    }

    func gameDoubleTapped(_ index: Int) {
        brain.flipCard(index)
    }

    func restart() {
        brain.restart()
    }

    func erase() {
        brain.erase()
    }
}

struct DigitButton: Identifiable {
    var id: Int

    var text: String { "\(id)"}
}
