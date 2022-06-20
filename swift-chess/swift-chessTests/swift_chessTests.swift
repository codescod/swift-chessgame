//
//  swift_chessTests.swift
//  swift-chessTests
//
//  Created by kevin.p on 2022/06/20.
//

import XCTest
@testable import swift_chess

class swift_chessTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testCheckPiecesExsitsInValidPosition() throws {
        let board = Board()
        
        guard let fileIdx = piece.pos.fileIndex else {
            return XCTAssertTrue(false)
        }
        
        for piece in board.pieces {
            if !( fileIdx >= 0 && fileIdx < 8) {
                return XCTAssertTrue(false)
            }
        }
        
        return XCTAssertTrue(true)
    }
    
    func testBoardCheckScore() throws {
        let board = Board()
        let score_1 = board.getScore()
        var score_2 = 0
        
        for p in board.pieces {
            score_2 += p.score
        }
        
        XCTAssertTrue(score_2 == score_1)
    }
    
    func testBoardCheckPiecesPosition() throws {
        let board = Board()
        
        
        let whitePawns = board.pieces.filter{$0.type == .Pawn}.filter{$0.pieceColor == .white}
        XCTAssertTrue(whitePawns.count == 8)
            
        let blackPawns = board.pieces.filter{$0.type == .Pawn}.filter{$0.pieceColor == .black}
        XCTAssertTrue(blackPawns.count == 8)
        
        let whiteKnights = board.pieces.filter{$0.type == .Knight}.filter{$0.pieceColor == .white}
        XCTAssertTrue(whiteKnights.count == 2)
        
        let blackKnights = board.pieces.filter{$0.type == .Knight}.filter{$0.pieceColor == .black}
        XCTAssertTrue(blackKnights.count == 2)
        
        let whiteBishops = board.pieces.filter{$0.type == .Bishop}.filter{$0.pieceColor == .white}
        XCTAssertTrue(whiteBishops.count == 2)
        
        let blackBishops = board.pieces.filter{$0.type == .Bishop}.filter{$0.pieceColor == .black}
        XCTAssertTrue(blackBishops.count == 2)
        
        let whiteQuuens = board.pieces.filter{$0.type == .Quuen}.filter{$0.pieceColor == .white}
        XCTAssertTrue(whiteQuuens.count == 1)
        
        let blackQuuens = board.pieces.filter{$0.type == .Quuen}.filter{$0.pieceColor == .black}
        XCTAssertTrue(blackQuuens.count == 1)
        
        let whiteKing = board.pieces.filter{$0.type == .King}.filter{$0.pieceColor == .white}
        XCTAssertTrue(whiteKing.count == 1)
        
        let blackKing = board.pieces.filter{$0.type == .King}.filter{$0.pieceColor == .black}
        XCTAssertTrue(blackKing.count == 1)
    }
    
    func testBoardMakePieces() throws {
        
    }
    
    func testBoardMovesPiece() throws {
        let board = Board()
        let testPos = "A2"
        print("\n\n명령을 입력하세요> ?\(testPos)")
        
        let avPoses = board.getPiecePositions(posStr: testPos)
        
        print("\n\(avPoses)")
        
        if let first = avPoses.first, avPoses.count == 1 {
            XCTAssertTrue("A3" == first.posStr)
        } else {
            XCTAssertFalse(true)
        }
    }
    
    func testPiecePositionIsValid() throws {
        
    }
    
    func testPieceColorIsValid() throws {
        
    }
    
    func testPieceShowsAvailablePositions() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
