import Foundation

struct SudokuBrain {
    var selected = 0 { didSet { prepareLines() }}
    var table: [Sudoku] = []
    var selectedDigit: Int {
        table[selected].value
    }
    init() {
        restart(SudokuPuzzle.sample)
    }

    var lines: Set<Int> = []

    mutating func prepareLines() {
        lines.removeAll()
        for i in 0..<table.count {
            let x = selected % 9
            let y = selected / 9

            if (i / 9 == y) || (i % 9 == x) || ((i / 9) / 3 == y / 3 && (i % 9) / 3 == x / 3) {
                lines.insert(i)
            }
        }
    }

    mutating func setValue(_ value: Int) {
        if !table[selected].isOrigin {
            if table[selected].value != 0 {
                table[selected].value = 0
                table[selected].notes = [value]
            } else if table[selected].value == 0 {
                if table[selected].notes.contains(value) {
                    table[selected].notes.remove(value)
                } else {
                    table[selected].notes.insert(value)
                }
            }
        }
    }

    mutating func flipCard(_ index: Int) {
        if table[index].value == 0, table[index].notes.count == 1, let value = table[index].notes.first, value == table[index].solution {
            if index != selected {
                selected = index
            }
            table[index].value = value
            lines.forEach {
                table[$0].notes.remove(value)
            }
        }
    }

    mutating func restart(_ sudoku: SudokuPuzzle) {
        let puzzle = sudoku.puzzle.compactMap {$0.wholeNumberValue }
        let solution = sudoku.solution.compactMap {$0.wholeNumberValue}
        guard puzzle.count > 80, solution.count > 80 else { return }
        table.removeAll()
        for i in 0..<81 {
            table.append(Sudoku(id: i, isOrigin: puzzle[i] != 0, value: puzzle[i], solution: solution[i]))
        }
        prepareLines()
    }

    mutating func erase() {
        if !table[selected].isOrigin {
            table[selected].value = 0
            table[selected].notes.removeAll()
        }
    }

    func digitCount(_ digit: Int) -> Int {
        var result = 0
        table.forEach {
            if $0.value == digit { result += 1}
        }
        return result
    }
}
