//
//  SudokuError.swift
//  
//
//  Created by Илья Шаповалов on 09.06.2024.
//

import Foundation

public enum SudokuError: Error, Equatable {
    case urlError(String)
    case badRequest
    case forbidden
    case decodingError(String)
    case unknown
    
    init?(_ statusCode: Int) {
        switch statusCode {
        case 401: self = .badRequest
        case 404: self = .forbidden
        default: return nil
        }
    }
    
    static func map(_ error: Error) -> SudokuError {
        switch error {
        case let error as SudokuError:
            return error
            
        case let error as URLError:
            return .urlError(error.localizedDescription)
            
        case let error as DecodingError:
            return .decodingError(error.localizedDescription)
            
        default:
            return .unknown
        }
    }
}
