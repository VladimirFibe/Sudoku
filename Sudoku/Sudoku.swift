import Foundation

struct Sudoku: Identifiable {
    let id: Int
    let isOrigin: Bool
    var value: Int
    var solution: Int
    var text: String {
        value == 0 ? "" : String(value)
    }
    var notes: Set<Int> = []
}

struct SudokuPuzzle: Codable {
    let puzzle: String
    let solution: String

    static let sample = SudokuPuzzle(
        puzzle: "070000043040009610800634900094052000358460020000800530080070091902100005007040802",
        solution: "679518243543729618821634957794352186358461729216897534485276391962183475137945862"
    )
}
