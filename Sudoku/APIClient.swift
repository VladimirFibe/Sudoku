import Foundation

final class APIClent {
    static let shared = APIClent()
    private init() {}

    func request() async throws -> SudokuResponse {
        guard let url = URL(string: "https://sudoku-game-and-api.netlify.app/api/sudoku")
        else { throw APIError.failedRequest}
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let result = try? JSONDecoder().decode(SudokuResponse.self, from: data)
        else { throw APIError.failedTogetData }
        return result
    }
}

enum APIError: Error {
    case failedRequest
    case failedTogetData
}
