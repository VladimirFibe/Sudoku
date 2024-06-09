//
//  File.swift
//  
//
//  Created by Илья Шаповалов on 09.06.2024.
//

import Foundation

/*
 {
 "game":"Sudoku",
 "created_by":"Amit Sharma",
 "info":"Each array in the data array represents a row in the sudoku grid.",
 "data":[
    [7,2,3,8,4,5,1,6,9],
    [1,6,4,7,3,9,5,2,8],
    [9,8,5,6,1,2,7,3,4],
    [4,1,8,3,6,7,2,9,5],
    [2,5,6,1,9,8,3,4,7],
    [3,9,7,5,2,4,6,8,1],
    [5,3,1,9,8,6,4,7,2],
    [6,4,9,2,7,1,8,5,3],
    [8,7,2,4,5,3,9,1,6]
 ],
 "easy":[
    [7,2,3,8,4,5,0,6,9],
    [0,6,0,7,3,0,5,0,8],
    [9,0,0,6,1,2,7,3,4],
    [4,1,8,0,0,7,0,0,5],
    [2,5,6,1,9,0,0,0,7],
    [3,9,7,0,2,0,0,0,0],
    [5,0,1,9,0,6,4,7,2],
    [6,4,0,0,7,1,8,5,3],
    [8,7,2,4,0,3,0,1,6]
 ],
 "medium":[
    [0,0,0,8,0,0,0,0,0],
    [0,6,4,0,3,0,0,2,0],
    [0,8,5,0,1,0,7,3,0],
    [0,0,8,3,6,7,2,0,5],
    [2,0,0,0,9,8,0,0,0],
    [3,0,7,5,2,0,6,0,1],
    [0,0,0,9,0,0,4,0,2],
    [6,0,0,0,0,1,0,0,0],
    [8,0,2,4,0,3,0,1,6]
 ],
 "hard":[
    [0,0,3,0,0,5,0,0,9],
    [0,0,4,0,0,0,5,0,0],
    [0,0,5,0,0,0,7,0,4],
    [4,0,0,0,0,0,0,0,0],
    [0,0,0,1,0,0,0,4,7],
    [0,9,7,5,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0],
    [6,4,9,0,0,0,0,0,0],
    [0,0,0,0,0,0,9,0,0]
 ],
 "date":"2024-06-09T16:10:20.210Z",
 "rules":[
    "Each row must contain the numbers 1-9 without repetition.",
    "Each column must contain the numbers 1-9 without repetition.",
    "Each of the nine 3x3 sub-boxes of the grid must contain the numbers 1-9 without repetition.",
    "The sum of every single row, column and 3x3 box must be 45."
 ],
 "difficulty":[
    "The difficulty is determined by the number of clues given.",
    "The fewer clues, the harder the puzzle.",
    "The more clues, the easier the puzzle."
 ],
 "projects":[
    {"title":"EVSTART: Electric Vehicle is the Future","url":"https://evstart.netlify.app/"},
    {"title":"News Website in react","url":"https://newsmon.netlify.app/"},
    {"title":"Hindi jokes API","url":"https://hindi-jokes-api.onrender.com/"}
 ],
 "usefullinks":[
    {"title":"6 Advanced Sudoku Strategies explained","url":"https://www.sudokuonline.io/tips/advanced-sudoku-strategies"},
    {"title":"Sudoku techniques","url":"https://www.conceptispuzzles.com/index.aspx?uri=puzzle/sudoku/techniques"}
 ]
 }
 */

public struct SudokuBoard: Decodable, Equatable {
    public let game: String
    public let createdBy: String
    public let info: String
    public let data: [[Int]]
    public let easy: [[Int]]
    public let medium: [[Int]]
    public let hard: [[Int]]
    public let date: Date
    public let rules: [String]
    public let difficulty: [String]
}

extension SudokuBoard: Encodable {}
