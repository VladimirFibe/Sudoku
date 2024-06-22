//
//  SudokuAPITests.swift
//
//
//  Created by Илья Шаповалов on 26.05.2024.
//

import XCTest
import Testing
@testable import SudokuNetworking

@Suite("Sudoku API manager tests")
struct SudokuAPITests_NEW {
    @Test func requestDosukuBoard() async throws {
        
    }
}

final class SudokuAPITests: XCTestCase {
    private var sut: SudokuAPI!
    
    override func setUp() async throws {
        try await super.setUp()
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [StubProtocol.self]
        sut = SudokuAPI(config)
    }
    
    override func tearDown() async throws {
        try await super.tearDown()
        
        sut = nil
        StubProtocol.didStartLoading = false
    }
    
    func test_request_sudoku_didStartLoading() async {
        _ = await sut.newBoardSudoku()
        
        XCTAssertTrue(StubProtocol.didStartLoading)
    }
    
    func test_request_sudoku_success() async {
        StubProtocol.responseHandler = { _ in
            Result
                .success(mockSudokuBoard)
                .tryMap(JSONEncoder().encode)
        }
        
        let result = await sut.newBoardSudoku()
        
        switch result {
        case .success(let board):
            XCTAssertEqual(board, mockSudokuBoard)
            
        case .failure:
            XCTFail()
        }
    }
    
    func test_request_sudoku_failed() async {
        StubProtocol.responseHandler = { _ in .failure(CocoaError(.coreData)) }
        
        let result = await sut.newBoardSudoku()
        
        switch result {
        case .success:
            XCTFail()
            
        case .failure(let error):
            XCTAssertEqual(error, .unknown)
        }
    }
    
    func test_request_dosuku_didStartLoading() async {
        _ = await sut.newBoardDosuku()
        
        XCTAssertTrue(StubProtocol.didStartLoading)
    }
    
    func test_request_dosuku_success() async {
        StubProtocol.responseHandler = { _ in
            Result
                .success(DosukuResponse(newboard: mockDosukuBoard))
                .tryMap(JSONEncoder().encode)
        }
        
        let result = await sut.newBoardDosuku()
        
        switch result {
        case .success(let board):
            XCTAssertEqual(board, mockDosukuBoard)
            
        case .failure:
            XCTFail()
        }
    }
    
    func test_request_dosuku_failed() async {
        StubProtocol.responseHandler = { _ in .failure(CocoaError(.coreData)) }
        
        let result = await sut.newBoardDosuku()
        
        switch result {
        case .success:
            XCTFail()
            
        case .failure(let error):
            XCTAssertEqual(error, .unknown)
        }
    }
}

private final class StubProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool { true }
    override class func canonicalRequest(for request: URLRequest) -> URLRequest { request }
    override func stopLoading() { }
    
    static var didStartLoading = false
    static var responseHandler: ((URL) -> Result<Data, Error>) = { _ in .failure(URLError(.unknown)) }
    
    override func startLoading() {
        Self.didStartLoading = true
        request.url
            .apply(Self.responseHandler)
            .zip(client)
            .map(redirectResult)
        client?.urlProtocolDidFinishLoading(self)
    }
    
    private func redirectResult(
        _ result: Result<Data, Error>,
        _ client: any URLProtocolClient
    ) {
        client.urlProtocol(self, didReceive: HTTPURLResponse(), cacheStoragePolicy: .notAllowed)
        
        switch result {
        case let .success(data):
            client.urlProtocol(self, didLoad: data)
            
        case let .failure(error):
            client.urlProtocol(self, didFailWithError: error)
        }
    }
    
}

private let mockSudokuBoard = SudokuBoard(
    game: "baz",
    createdBy: "bar",
    info: "foo",
    data: [],
    easy: [],
    medium: [],
    hard: [],
    date: "baz",
    rules: [],
    difficulty: []
)

private let mockDosukuBoard = DosukuBoard(
    grids: [],
    results: 0,
    message: "baz"
)
