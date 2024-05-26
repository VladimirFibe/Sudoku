import Foundation

struct Sudoku: Identifiable {
    let id: Int
    var value: Int
    var text: String {
        value == 0 ? "" : String(value)
    }
    var notes: Set<Int> = []
}
