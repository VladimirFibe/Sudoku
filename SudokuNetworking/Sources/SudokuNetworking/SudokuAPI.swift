import Foundation
import SwiftFP

/// Класс `SudokuAPI` предоставляет механизм взаимодействия с несколькими ресурсами-поставщиками судоку.
///
/// `SudokuAPI` можно использовать в формате синглтона, через статическое свойство `SudokuAPI.shared`.
/// Так же, для более тонкой настройки, можно инициализировать экземпляр `SudokuAPI` с кастомным
/// конфигом (`URLSessionConfiguration`) и/или механизмом логирования.
///
/// Встроенный логер `SudokuAPI` возвращает словать с ключами: `"Object"`, `"Event"`  и `"Error"`.
///  - Object: содержит имя объекта `SudokuAPI`
///  - Event: текущий логируемый ивент
///  - Error: состояние объекта и/или текущего обрабатываемого ивента
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
            .map(log(request:))
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
        let event = "Receive response:\n".appending(String(reflecting: httpResponse))
        if let error = SudokuError(httpResponse.statusCode) {
            log(event: event, error: error)
            throw error
        }
        log(event: event)
        return response.data
    }
    
    func log<Model>(
        processing request: URLRequest
    ) -> (Result<Model, SudokuError>) -> Result<Model, SudokuError> {
        { [self] result in
            let event = "Process response: "
            switch result {
            case .success:
                log(event: event.appending("success"))
                
            case let .failure(error):
                log(event: event.appending("failure"), error: error)
            }
            return result
        }
    }
    
    func log(request: URLRequest) -> URLRequest {
        log(event: "Send Request:\n".appending(String(reflecting: request)))
        return request
    }
    
    func log(event: String, error: Error? = nil) {
        logger?(
            [
                "Object" : String(describing: self),
                "Event" : event,
                "Error" : String(reflecting: error)
            ]
        )
    }
}
