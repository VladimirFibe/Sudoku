//
//  GraphQLQueryBuilderTest.swift
//
//
//  Created by Илья Шаповалов on 22.06.2024.
//

import Testing
@testable import GraphQLQueryBuilder

@Suite("GraphQL Query types and builder tests")
struct GraphQLQueryBuilderTest {

    @Test func renderProperty() async throws {
        let sut = GraphProperty("baz").render()
        
        #expect(sut == "baz")
    }
    
    @Test func renderType() async throws {
        let sut = GraphType(type: "baz") {
            GraphProperty("bar")
        }.render()
        
        #expect(sut == "baz{bar}")
    }

    @Test func renderMultipleTypes() async throws {
        let sut = GraphType(type: "baz") {
            GraphProperty("bar")
            GraphProperty("foo")
        }
        
        #expect(sut.render() == "baz{bar,foo}")
    }
    
    @Test(arguments: [true, false])
    func renderTypesWithIfCondition(condition: Bool) async throws {
        let sut = GraphType(type: "baz") {
            GraphProperty("bar")
            if condition {
                GraphProperty("foo")
            }
        }.render()
        
        if condition {
            #expect(sut == "baz{bar,foo}")
        } else {
            #expect(sut == "baz{bar}")
        }
    }
    
    @Test(arguments: [true, false])
    func renderTypesWithSwitchCondition(condition: Bool) async throws {
        let sut = GraphType(type: "baz") {
            switch condition {
            case true:
                GraphProperty("bar")
            
            case false:
                GraphProperty("foo")
            }
        }.render()
        
        if condition {
            #expect(sut == "baz{bar}")
        } else {
            #expect(sut == "baz{foo}")
        }
    }
}
