//
//  Queries.swift
//
//
//  Created by Илья Шаповалов on 22.06.2024.
//

import Foundation

public protocol GraphQLQuery {
    func render() -> String
}

extension String: GraphQLQuery {
    public func render() -> String { self }
}

//MARK: - GraphProperty
struct GraphProperty: GraphQLQuery {
    let name: String
    init(_ name: String) { self.name = name }
    
    func render() -> String { name }
}

//MARK: - GraphType
struct GraphType: GraphQLQuery {
    let type: String
    @GraphQLQueryBuilder let embedded: () -> [GraphQLQuery]
    
    func render() -> String {
        type.appending("{")
            .appending(embedded().map { $0.render() }.joined(separator: ","))
            .appending("}")
    }
}
