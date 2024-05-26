import Foundation

struct SudokuBrain {
    var selected = 0 { didSet { prepareLines() }}
    init() {
        prepareLines()
    }
    var game = [  0, 6, 0,    0, 0, 2,    0, 0, 0,
                  0, 0, 3,    0, 0, 0,    0, 0, 1,
                  4, 0, 0,    8, 6, 0,    0, 9, 0,

                  5, 0, 0,    0, 0, 7,    0, 0, 0,
                  0, 1, 0,    2, 5, 0,    0, 0, 9,
                  0, 0, 0,    0, 0, 4,    0, 2, 0,

                  6, 0, 0,    5, 9, 0,    0, 8, 0,
                  0, 0, 0,    0, 7, 0,    0, 0, 0,
                  0, 4, 0,    0, 0, 0,    6, 0, 0]

    var lines: Set<Int> = []

    mutating func prepareLines() {
        lines.removeAll()
        for i in 0..<game.count {
            let x = selected % 9
            let y = selected / 9

            if (i / 9 == y) || (i % 9 == x) || ((i / 9) / 3 == y / 3 && (i % 9) / 3 == x / 3) {
                lines.insert(i)
            }
        }
        print(lines)
    }
}
