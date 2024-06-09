//
//  EndpointTests.swift
//  
//
//  Created by Илья Шаповалов on 26.05.2024.
//

import XCTest
@testable import SudokuNetworking

final class EndpointTests: XCTestCase {
    func test_configureEndpoint() {
        let sut = Endpoint.new
            .setScheme(.https)
            .setHost("baz.bar")
            .setPath("foo")
            .addSubPath("baz")
            .addQuery {
                URLQueryItem(name: "baz", value: "bar")
            }
        
        XCTAssertEqual(sut.scheme, "https")
        XCTAssertEqual(sut.host, "baz.bar")
        XCTAssertEqual(sut.path, "/foo/baz")
        XCTAssertEqual(
            sut.queryItems,
            [URLQueryItem(name: "baz", value: "bar")]
        )
        XCTAssertEqual(
            sut.url,
            URL(string: "https://baz.bar/foo/baz?baz=bar")
        )
        XCTAssertEqual(
            sut.composeUrl().value,
            URL(string: "https://baz.bar/foo/baz?baz=bar")
        )
    }

    func test_newBoard() {
        let sut = Endpoint.newBoard_dosuku
        
        XCTAssertEqual(
            sut.composeUrl().value,
            URL(string: "https://sudoku-api.vercel.app/api/dosuku")
        )
    }
    
    func test_newBoard_netlify() {
        let sut = Endpoint.newBoard_sudoku
        
        XCTAssertEqual(
            sut.composeUrl().value,
            URL(string: "https://sudoku-game-and-api.netlify.app/api/sudoku")
        )
    }
}
