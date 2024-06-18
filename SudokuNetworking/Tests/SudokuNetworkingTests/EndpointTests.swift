//
//  EndpointTests.swift
//  
//
//  Created by Илья Шаповалов on 26.05.2024.
//

import Testing
import Foundation
@testable import SudokuNetworking

@Suite("Endpoint tests")
struct EndpointTesting {
    
    @Test 
    func configurations() async throws {
        let sut = Endpoint.new
            .setScheme(.https)
            .setHost("baz.bar")
            .setPath("foo")
            .addSubPath("baz")
            .addQuery {
                URLQueryItem(name: "baz", value: "bar")
            }
        #expect(sut.scheme == "https")
        #expect(sut.host == "baz.bar")
        #expect(sut.path == "/foo/baz")
        #expect(sut.queryItems == [URLQueryItem(name: "baz", value: "bar")])
        #expect(sut.composeUrl().absoluteString == "https://baz.bar/foo/baz?baz=bar")
    }
    
    @Test
    func newBoard() async throws {
        let sut = Endpoint.newBoard_dosuku
        
        #expect(sut.composeUrl().absoluteString == "https://sudoku-api.vercel.app/api/dosuku")
    }
    
    @Test
    func test_newBoard_netlify() async throws {
        let sut = Endpoint.newBoard_sudoku
        
        #expect(sut.composeUrl().absoluteString == "https://sudoku-game-and-api.netlify.app/api/sudoku")
    }
}
