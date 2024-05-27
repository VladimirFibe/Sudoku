import Foundation

final class APIClent {
    static let shared = APIClent()
    private init() {}

    func request<Response: Decodable>(_ urlString: String) async throws -> Response {
        guard let url = URL(string: urlString)
        else { throw APIError.failedRequest}
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let result = try? decoder.decode(Response.self, from: data)
        else { throw APIError.failedTogetData }
        return result
    }
}

enum APIError: Error {
    case failedRequest
    case failedTogetData
}
