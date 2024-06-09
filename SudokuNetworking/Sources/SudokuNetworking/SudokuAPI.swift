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
        await Endpoint
            .newBoard_sudoku
            .composeUrl()
            .flatMap(Request.new(_:))
            .setMethod(.GET)
            .map(Result.success)
            .value
            .asyncTryMap(session.data(for:))
            .tryMap(unwrapResponse)
            .decode(SudokuBoard.self, decoder: decoder)
            .mapError(SudokuError.map(_:))
    }
}

private extension SudokuAPI {
    typealias Response = (data: Data, response: URLResponse)
    
    func unwrapResponse(_ response: Response) throws -> Data {
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
