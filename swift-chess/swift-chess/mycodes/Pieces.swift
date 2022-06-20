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

    var pos: Position
    let type: PieceType
    
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
        if pieceColor == .black {
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
        self.pos = Position(posStr: posStr)
        
        self.type = type
        self.pieceColor = pieceColor
    }

    func getAvailablePosition(boardPieces: [Pieces]) -> [Position] {
        var normalMovePosition: [Position?] = []
        var attackMovePosition: [Position?] = []
        
        if type == .Pawn {
            if pieceColor == .black {
                normalMovePosition.append(pos.indexToPosition(file_mov: 0, rank_mov: +1))
                attackMovePosition.append(pos.indexToAttackPosition(file_mov: -1, rank_mov: +1, boardPieces: boardPieces))
                attackMovePosition.append(pos.indexToAttackPosition(file_mov: +1, rank_mov: +1, boardPieces: boardPieces))
            } else {
                normalMovePosition.append(pos.indexToPosition(file_mov: 0, rank_mov: -1))
                attackMovePosition.append(pos.indexToAttackPosition(file_mov: -1, rank_mov: -1, boardPieces: boardPieces))
                attackMovePosition.append(pos.indexToAttackPosition(file_mov: +1, rank_mov: -1, boardPieces: boardPieces))
            }
        }
        
        return normalMovePosition.compactMap{ $0 }
    }
    
    
}

struct Position {
    var posStr: String
    
    init(posStr: String) {
        self.posStr = posStr
        
    }
    
    var rankStr: Character {
        return Array(posStr)[1]
    }
    var fileStr: Character {
        return Array(posStr)[0]
    }
    
    var rankIndex: Int? {
        switch rankStr {
        case "1": return 0
        case "2": return 1
        case "3": return 2
        case "4": return 3
        case "5": return 4
        case "6": return 5
        case "7": return 6
        case "8": return 7
        default: return nil
        }
    }
    
    var fileIndex: Int? {
        switch fileStr {
        case "A": return 0
        case "B": return 1
        case "C": return 2
        case "D": return 3
        case "E": return 4
        case "F": return 5
        case "G": return 6
        case "H": return 7
        default: return nil
        }
    }
    
    func indexToPosition(file_mov: Int, rank_mov: Int) -> Position? {
        guard let fileIndex = fileIndex, let rankIndex = rankIndex else {
            return nil
        }
        
        let fileIdx = fileIndex + file_mov
        let rankIdx = rankIndex + rank_mov
        
        if rankIdx >= 0 && rankIdx < 8 && fileIdx >= 0 && fileIdx < 8 {
            return Position(posStr: "\(alphabets[fileIdx])\(rankIdx + 1)")
        } else {
            return nil
        }
    }
    
    func indexToAttackPosition(file_mov: Int, rank_mov: Int, boardPieces: [Pieces]) -> Position? {
        guard let fileIndex = fileIndex, let rankIndex = rankIndex else {
            return nil
        }
        
        let fileIdx = fileIndex + file_mov
        let rankIdx = rankIndex + rank_mov
        
        if rankIdx >= 0 && rankIdx < 8 && fileIdx >= 0 && fileIdx < 8 {
            let newPosStr = "\(alphabets[fileIdx])\(rankIdx + 1)"
            if let nPos = boardPieces.map({$0.pos}).filter({ $0.posStr ==  newPosStr}).first {
                return Position(posStr: nPos.posStr)
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
