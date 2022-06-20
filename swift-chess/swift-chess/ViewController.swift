//
//  ViewController.swift
//  swift-chess
//
//  Created by kevin.p on 2022/06/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let board = Board()
        
        let avPoses = board.getPiecePositions(posStr: "A2")
    }


}

