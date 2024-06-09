//
//  Request.swift
//
//
//  Created by Илья Шаповалов on 26.05.2024.
//

import Foundation
import SwiftFP

typealias Request = Monad<URLRequest>

extension Request {
    @usableFromInline
    enum HTTPMethod: String { case GET, POST, PUT, DELETE }
    
    @inlinable
    func mutate(_ transform: (inout Wrapped) -> Void) -> Self {
        map { old in
            var new = old
            transform(&new)
            return new
        }
    }
    
    //MARK: - Configuration
    @inlinable
    static func new(_ url: URL) -> Self {
        Self(.init(url: url))
    }
    
    @inlinable
    func setMethod(_ m: HTTPMethod) -> Self {
        mutate { $0.httpMethod = m.rawValue }
    }
    
    
}
