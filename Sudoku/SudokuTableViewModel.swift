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

    func getSudoku(_ zeros: Int) {
        let game = Bundle.main.decode([SudokuPuzzle].self, from: "Sudoku.json")
        let hard = game.filter { $0.zeros > zeros - 5 && $0.zeros < zeros + 5}
        guard let puzzle = hard.randomElement() else { return }
        brain.restart(puzzle)
    }

    func erase() {
        brain.erase()
    }

    func digitCount(_ digit: Int) -> Int {
        brain.digitCount(digit)
    }

    func flipCard(_ index: Int) {
        brain.setAndFlipCard(index)
    }
}

struct DigitButton: Identifiable {
    var id: Int

    var text: String { "\(id)"}
}
