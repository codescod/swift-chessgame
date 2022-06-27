//
//  BoardView.swift
//  swift-chess
//
//  Created by kevin.p on 2022/06/27.
//

import Foundation
import UIKit

class BoardView: UIView {
    let board = Board()
    var piecesViews: [PieceView] = []
    var current_tapped_view: PieceView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        display()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        display()
    }
    
    func display() {
        var x = 0
        var y = 0
        let width = 30
        let height = 30
        
        for r in rank {
            x = 0
            
            for f in file {
                let posStr = "\(f)\(r)"
                
                let pieceView = PieceView(frame: CGRect(x: x, y: y, width: width, height: height))
                pieceView.posStr = posStr
                
                let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
                label.textAlignment = .center
                
                let piece = board.getPieceByPosStr(posStr: posStr)
                if let emojiStr = piece?.emojiString {
                    label.text = emojiStr
                } else {
                    label.text = "."
                }
                
                pieceView.addSubview(label)
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
                pieceView.addGestureRecognizer(tap)
                
                piecesViews.append(pieceView)
                self.addSubview(pieceView)
                x += width
            }
            
            y += height
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        let movable_views = piecesViews.filter({ $0.tapped == true })
        if movable_views.count > 0 {
            if let from_posStr = current_tapped_view?.posStr, let toView = sender?.view as? PieceView, let toStr = toView.posStr {
                print("from: \(from_posStr), to: \(toStr)")
                _ = board.updateBoard(from: Position(posStr: from_posStr), to: Position(posStr: toStr))
            }
            
            _ = piecesViews.map({
                $0.tapped = false
                $0.layer.borderColor = UIColor.clear.cgColor
            })
            
            current_tapped_view = nil
            
            display()
        } else {
            _ = piecesViews.map({
                $0.tapped = false
                $0.layer.borderColor = UIColor.clear.cgColor
            })
            
            if let pieceView = sender?.view as? PieceView, let posStr = pieceView.posStr {
                let movablePositions = board.getPiecePositions(posStr: posStr) // ["B3", "A3"] 이런식
                
                current_tapped_view = pieceView
                
                for pos in movablePositions {
                    if let rect_view = piecesViews.filter({ $0.posStr == pos.posStr }).first {
                        rect_view.layer.borderWidth = 1.0
                        rect_view.layer.borderColor = UIColor.orange.cgColor
                        rect_view.tapped = true
                    }
                }
            } else {
                print("no pieceView!")
            }
        }
    }
    
}

class PieceView: UIView {
    var posStr: String?
    var tapped: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
