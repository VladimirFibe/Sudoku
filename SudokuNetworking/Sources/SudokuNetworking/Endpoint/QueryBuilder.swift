//
//  QueryBuilder.swift
//
//
//  Created by Илья Шаповалов on 26.05.2024.
//

import Foundation

@usableFromInline
@resultBuilder
enum QueryBuilder {
    
    @inlinable
    static func buildBlock(_ components: URLQueryItem...) -> [URLQueryItem] {
        components
    }
    
}
