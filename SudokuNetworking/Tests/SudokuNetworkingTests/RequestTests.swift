//
//  RequestTests.swift
//
//
//  Created by Илья Шаповалов on 26.05.2024.
//

import XCTest
@testable import SudokuNetworking

final class RequestTests: XCTestCase {
    func test_configureRequest() {
        let sut = Request
            .new(URL(string: "https://baz.bar.foo")!)
            .setMethod(.GET)
        
        XCTAssertEqual(sut.httpMethod, "GET")
    }
}
