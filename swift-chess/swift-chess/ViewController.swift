//
//  ViewController.swift
//  swift-chess
//
//  Created by kevin.p on 2022/06/20.
//

import UIKit

class ViewController: UIViewController {
    let boardView = BoardView(frame: CGRect(x: 50, y: 50, width: 350, height: 350))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let board = Board()
//
//        let avPoses = board.getPiecePositions(posStr: "A2")
        
//        board.updateBoard(from: Position(posStr: "A2"), to: Position(posStr: "A3"))
        
//        board.display()
        
        self.view.addSubview(boardView)
        
    }


}

