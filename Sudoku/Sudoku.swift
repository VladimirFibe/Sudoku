import Foundation

struct Sudoku: Identifiable {
    let id: Int
    let value: Int
    var text: String {
        String(value)
    }
}
