//
//  SudokuError.swift
//  
//
//  Created by Илья Шаповалов on 09.06.2024.
//

import Foundation

public enum SudokuError: Error {
    case unknown
    
    static func map(_ error: Error) -> SudokuError {
        switch error {
            
            
        default:
            return .unknown
        }
    }
}
