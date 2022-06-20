//
//  Pieces.swift
//  swift-chess
//
//  Created by kevin.p on 2022/06/20.
//

import Foundation

enum PieceType {
    case Pawn, Bishop, Luke, Quuen, Knight, King
}

enum PieceColor {
    case white, black
}

class Pieces {
    var garo: Int {
        switch rankStr {
        case "A": return 0
        case "B": return 1
        case "C": return 2
        case "D": return 3
        case "E": return 4
        case "F": return 5
        case "G": return 6
        case "H": return 7
        default: return 8
        }
    }
    
    var sero: Int {
        switch rankStr {
        case "1": return 0
        case "2": return 1
        case "3": return 2
        case "4": return 3
        case "5": return 4
        case "6": return 5
        case "7": return 6
        case "8": return 7
        default: return 8
        }
    }
    
    let type: PieceType
    
    var fileStr: Character
    var rankStr: Character
    
    var pieceColor: PieceColor
    
    var score: Int {
        switch type {
        case .Pawn:
            return 1
        default:
            return 0
        }
    }
    
    //♜♞♝.♛♝♞♜
    var emojiString: String {
        if pieceColor == .black{
            switch type {
            case .Pawn:
                return "♟"
            case .Bishop:
                return "♝"
            case .Luke:
                return "♜"
            case .Quuen:
                return "♛"
            case .Knight:
                return "♞"
            case .King:
                return "."
            }
        } else {
            switch type { //♖♘♗.♕♗♘♖
            case .Pawn:
                return "♙"
            case .Bishop:
                return "♗"
            case .Luke:
                return "♖"
            case .Quuen:
                return "♕"
            case .Knight:
                return "♘"
            case .King:
                return "."
            }
        }
    }
    
    init(posStr: String, type: PieceType, pieceColor: PieceColor) {
        let arr = Array(posStr)

        self.fileStr = arr[0]
        self.rankStr = arr[1]
        
        self.type = type
        self.pieceColor = pieceColor
    }
    
    func getAvailablePosition() -> [] {
        
    }
}


