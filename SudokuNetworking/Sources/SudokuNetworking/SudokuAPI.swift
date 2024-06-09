import Foundation
import SwiftFP

public final class SudokuAPI {
    public static let shared = SudokuAPI()
    
    private let session: URLSession
    private let decoder: JSONDecoder
    private let logger: (([String: Any]) -> Void)?
    
    //MARK: - init(_:)
    public init(
        _ config: URLSessionConfiguration = .default,
        logger: (([String: Any]) -> Void)? = nil
    ) {
        self.logger = logger
        session = URLSession(configuration: config)
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        log(event: #function)
    }
    
    deinit {
        log(event: #function)
    }
    
    //MARK: - Public methods
    public func newBoardSudoku() async -> Result<SudokuBoard, SudokuError> {
        await request(.newBoard_sudoku)
            .asyncMap(perform(request:))
            .value
    }
    
    public func newBoardDosuku() async -> Result<DosukuBoard, SudokuError> {
        await request(.newBoard_dosuku)
            .asyncMap(perform(request:))
            .value
    }
}

private extension SudokuAPI {
    typealias Response = (data: Data, response: URLResponse)
    
    func request(_ endpoint: Endpoint, method: Request.HTTPMethod = .GET) -> Request {
        endpoint
            .composeUrl()
            .flatMap(Request.new(_:))
            .setMethod(method)
    }
    
    func perform<T: Decodable>(request: URLRequest) async -> Result<T, SudokuError> {
        await Result
            .success(request)
            .asyncTryMap(session.data(for:))
            .tryMap(unwrapResponse)
            .decode(T.self, decoder: decoder)
            .mapError(SudokuError.map(_:))
    }
    
    func unwrapResponse(_ response: Response) throws -> Data {
        guard let httpResponse = response.response as? HTTPURLResponse else {
            preconditionFailure()
        }
        if let error = SudokuError(httpResponse.statusCode) {
            throw error
        }
        return response.data
    }
    
    func log(event: String) {
        logger?(
            [
                "Object" : String(describing: self),
                "Event" : event
            ]
        )
    }
}
