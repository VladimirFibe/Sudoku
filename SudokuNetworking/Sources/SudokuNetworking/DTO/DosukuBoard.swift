//
//  DosukuBoard.swift
//  
//
//  Created by Илья Шаповалов on 09.06.2024.
//

import Foundation

struct DosukuResponse: Decodable {
    let newboard: DosukuBoard
}

public struct DosukuBoard: Decodable, Equatable {
    public let grids: [Grid]
    public let results: Int
    public let message: String
}

public extension DosukuBoard {
    enum Difficulty: String, Decodable {
        case Easy
        case Medium
        case Hard
    }
    
    struct Grid: Decodable, Equatable {
        public let value: [[Int]]
        public let solution: [[Int]]
        public let difficulty: Difficulty
    }
}

extension DosukuResponse: Encodable {}
extension DosukuBoard: Encodable {}
extension DosukuBoard.Difficulty: Encodable {}
extension DosukuBoard.Grid: Encodable {}
