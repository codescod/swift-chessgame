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
        
//        self.delegate = board
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
    
//    func movePieces(from: Position, to: Position) -> Bool {
//        return delegate.updateBoard(from: from, to: to)
//    }
    
}

struct Position: Hashable {
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
            return Position(posStr: "\(file[fileIdx])\(rankIdx + 1)")
        } else {
            return nil
        }
    }
    
    // position이 class였다면, 리턴값을 막 사용하지 못할텐데, 저는 포지션에 있어서는 stateless한 데이터를 제공하고 싶었습니다. 요구사항이 가능한 포지션을 리턴하라는 것이라서, 의미적으로 이것을 확인하고 아무짓을 해도 상관없게 하고싶었습니다.
    func indexToAttackPosition(file_mov: Int, rank_mov: Int, boardPieces: [Pieces]) -> Position? {
        guard let fileIndex = fileIndex, let rankIndex = rankIndex else {
            return nil
        }
        
        let fileIdx = fileIndex + file_mov
        let rankIdx = rankIndex + rank_mov
        
        if rankIdx >= 0 && rankIdx < 8 && fileIdx >= 0 && fileIdx < 8 {
            let newPosStr = "\(file[fileIdx])\(rankIdx + 1)"
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
