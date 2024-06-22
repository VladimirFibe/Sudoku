//
//  GraphQLQueryBuilder.swift
//
//
//  Created by Илья Шаповалов on 22.06.2024.
//

import Foundation

@resultBuilder
public enum GraphQLQueryBuilder {
    @inlinable
    public static func buildBlock(_ components: GraphQLQuery...) -> [GraphQLQuery] {
        components
    }
    
    @inlinable
    public static func buildBlock(_ components: [GraphQLQuery]...) -> [GraphQLQuery] {
        components.flatMap { $0 }
    }
    
    @inlinable
    public static func buildExpression(_ expression: GraphQLQuery) -> [GraphQLQuery] {
        [expression]
    }
    
    @inlinable
    public static func buildOptional(_ component: [GraphQLQuery]?) -> [GraphQLQuery] {
        component ?? []
    }
    
    @inlinable
    public static func buildEither(first component: [GraphQLQuery]) -> [GraphQLQuery] {
        component
    }
    
    @inlinable
    public static func buildEither(second component: [GraphQLQuery]) -> [GraphQLQuery] {
        component
    }
}
