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
            let garo: Character = p.fileStr
            let sero: String = String(p.sero)
            
            let pos = "\(garo)\(sero)"
            
            piecePositions[pos] = p.emojiString
        }
        
        for se in 0..<8 {
            boardStatus += "\(se + 1)"
            
            for ga in 0..<8 {
                let garo: String = alphabets[ga]
                let sero: String = String(se)
                let pos = "\(garo)\(sero)"
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
    
}
