import Foundation

struct SudokuBrain {
    var selected = 0 { didSet { prepareLines() }}
    var table: [Sudoku] = []
    var selectedDigit: Int {
        table[selected].value
    }
    init() {
        restart(sample)
    }
    var sample = [[0, 0, 0, 0, 0, 0, 0, 0, 0], [3, 0, 0, 0, 2, 0, 0, 0, 0], [0, 9, 0, 1, 0, 0, 7, 0, 0], [0, 4, 0, 0, 0, 0, 6, 1, 9], [0, 0, 0, 0, 0, 0, 0, 0, 0], [7, 1, 0, 0, 0, 0, 8, 5, 0], [0, 0, 0, 0, 0, 8, 0, 0, 0], [1, 0, 0, 3, 0, 0, 0, 0, 0], [6, 0, 0, 0, 1, 7, 0, 0, 0]]

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
        if table[index].value == 0, table[index].notes.count == 1, let value = table[index].notes.first {
            if index != selected {
                selected = index
            }
            table[index].value = value
            lines.forEach {
                table[$0].notes.remove(value)
            }
        }
    }

    mutating func restart(_ hard: [[Int]]) {
        table.removeAll()
        for i in 0..<9 {
            for j in 0..<9 {
                let value = hard[i][j]
                let sudoku = Sudoku(id: 9*i+j, isOrigin: value != 0, value: value)
                table.append(sudoku)
            }
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
