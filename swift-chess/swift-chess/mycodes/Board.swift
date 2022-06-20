//
//  Board.swift
//  swift-chess
//
//  Created by kevin.p on 2022/06/20.
//

import Foundation

let alphabets = ["A", "B", "C", "D", "E", "F", "G", "H"]

class Board {
    
    var pieces: [Pieces] = []
    
    init() {
        setInitPieces()
        display()
    }
    
    private func setInitPieces() {
        for alp in alphabets {
            pieces.append(Pieces(posStr: "\(alp)2", type: .Pawn, pieceColor: .black))
        }
        
        pieces.append(Pieces(posStr: "A1", type: .Luke, pieceColor: .black))
        pieces.append(Pieces(posStr: "B1", type: .Knight, pieceColor: .black))
        pieces.append(Pieces(posStr: "C1", type: .Bishop, pieceColor: .black))
        pieces.append(Pieces(posStr: "D1", type: .King, pieceColor: .black))
        
        pieces.append(Pieces(posStr: "H1", type: .Luke, pieceColor: .black))
        pieces.append(Pieces(posStr: "G1", type: .Knight, pieceColor: .black))
        pieces.append(Pieces(posStr: "F1", type: .Bishop, pieceColor: .black))
        pieces.append(Pieces(posStr: "E1", type: .Quuen, pieceColor: .black))
        
        for alp in alphabets {
            pieces.append(Pieces(posStr: "\(alp)7", type: .Pawn, pieceColor: .white))
        }
        pieces.append(Pieces(posStr: "A8", type: .Luke, pieceColor: .white))
        pieces.append(Pieces(posStr: "B8", type: .Knight, pieceColor: .white))
        pieces.append(Pieces(posStr: "C8", type: .Bishop, pieceColor: .white))
        pieces.append(Pieces(posStr: "D8", type: .King, pieceColor: .white))
        
        pieces.append(Pieces(posStr: "H8", type: .Luke, pieceColor: .white))
        pieces.append(Pieces(posStr: "G8", type: .Knight, pieceColor: .white))
        pieces.append(Pieces(posStr: "F8", type: .Bishop, pieceColor: .white))
        pieces.append(Pieces(posStr: "E8", type: .Quuen, pieceColor: .white))
    }
    
    func getScore() -> Int {
        let sum = pieces.map {$0.score}.reduce(0){$0 + $1}
        return sum
    }
    
    fileprivate func showCurrentBoardStatus() -> String {
        var boardStatus = " ABCDEFGH\n"
        
        var piecePositions: [String: String] = [:]
        for p in pieces {
            let file = p.pos.fileStr
            let rank = p.pos.rankStr
            
            let pos = "\(file)\(rank)"
            
            piecePositions[pos] = p.emojiString
        }
        
        for se in 0..<8 {
            boardStatus += "\(se + 1)"
            
            for ga in 0..<8 {
                let file: String = alphabets[ga]
                let rank: String = String(se + 1)
                let pos = "\(file)\(rank)"
                if let emoji = piecePositions[pos] {
                    boardStatus += "\(emoji)"
                } else {
                    boardStatus += "."
                }
            }
            boardStatus += "\n"
        }
        boardStatus += " ABCDEFGH"
        return boardStatus
    }
    
    func display() {
        print(showCurrentBoardStatus())
    }
    
    func getPiecePositions(posStr: String) -> [Position] {
        
        guard let selectedPiece = pieces.filter({
            return $0.pos.posStr == posStr
        }).first else {
            print("가능한 이동 방법이 없습니다.\n")
            return []
        }
        
        let availablePos = selectedPiece.getAvailablePosition(boardPieces: pieces)
        
        for p in availablePos {
            print("\(p.posStr) ")
        }
        print("\n\n")
        return availablePos
    }
}

extension Board {
    // 이 함수의 사용전에 이동을 위해서는 각 말의 이동 가능 여부를 확인 후 이동해야한다.
    private func updateBoard(from: Position, to: Position) -> Bool {
        if let toPiece = pieces.filter({ $0.pos == from }).first {
            pieces = pieces.filter { $0.pos != to }
            toPiece.pos = to
            
            return true
        } else {
            return false
        }
    }
}
