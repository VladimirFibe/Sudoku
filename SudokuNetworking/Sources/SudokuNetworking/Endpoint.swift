//
//  Endpoint.swift
//
//
//  Created by Илья Шаповалов on 26.05.2024.
//

import Foundation
import SwiftFP

typealias Endpoint = Monad<URLComponents>

extension Endpoint {
    @usableFromInline
    enum Scheme: String { case http, https }
    
    @inlinable
    func mutate(_ transform: (inout Wrapped) -> Void) -> Self {
        map { old in
            var new = old
            transform(&new)
            return new
        }
    }
    
    //MARK: - Configuration
    static let new = Endpoint(.init())
    
    @inlinable
    func setScheme(_ s: Scheme) -> Self {
        mutate { $0.scheme = s.rawValue }
    }
    
    @inlinable
    func setHost(_ h: String) -> Self {
        mutate { $0.host = h }
    }
    
    @inlinable
    func setPath(_ p: String) -> Self {
        mutate { $0.path = "/".appending(p) }
    }
    
    @inlinable
    func addSubPath(_ p: String) -> Self {
        mutate { $0.path.append("/".appending(p)) }
    }
    
    @inlinable
    func addQuery(
        @QueryBuilder _ build: () -> [URLQueryItem]
    ) -> Self {
        mutate { components in
            if components.queryItems == nil {
                components.queryItems = build()
                return
            }
            components.queryItems?.append(contentsOf: build())
        }
    }
    
    @inlinable
    func composeUrl() -> Monad<URL> {
        map { components in
            if let url = components.url { return url }
            preconditionFailure("Unable to create url from: \(components)")
        }
    }
    
    //MARK: - Endpoints
    static let newBoard = Endpoint
        .new
        .setScheme(.https)
        .setHost("sudoku-api.vercel.app")
        .setPath("api")
        .addSubPath("dosuku")
}
