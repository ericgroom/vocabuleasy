//
//  ReviewSessionTests.swift
//  VocabuleasyTests
//
//  Created by Eric Groom on 5/4/19.
//  Copyright © 2019 Eric Groom. All rights reserved.
//

import XCTest
@testable import Vocabuleasy

class ReviewSessionTests: XCTestCase {
    
    var mockSession: ReviewSession!

    override func setUp() {
        var cards: [Card] = []
        for i in 0..<20 {
            let card = Card(front: "front \(i)", back: "back \(i)")
            cards.append(card)
        }
        mockSession = ReviewSession(cards: cards)
    }

    override func tearDown() {
        
    }

    func testEmptyInit() {
        let session = ReviewSession(cards: [])
        let initialIndex = session.currentIndex
        XCTAssertFalse(session.canAdvance, "Empty session shouldn't be able to advance")
        XCTAssertFalse(session.canGoBack, "Empty session shouldn't be able to go back")
        XCTAssertNil(session.advance(), "Advance should return nil when it cannot advance")
        XCTAssertEqual(initialIndex, session.currentIndex, "Index shouldn't change if cannot advance")
        XCTAssertNil(session.goBack(), "Go back should return nil when it cannot go back")
        XCTAssertEqual(initialIndex, session.currentIndex, "Index shouldn't change if cannot go back")
    }
    
    func testSequence() {
        let session = mockSession!
        let initialIndex = session.currentIndex
        XCTAssertTrue(session.count > 0, "Further tests assume session has cards")
        XCTAssertTrue(session.canAdvance, "Session should be able to advance when it had memebers")
        XCTAssertFalse(session.canGoBack, "New sessions should not be able to go back")
        XCTAssertNotNil(session.advance(), "Session should return the next card when advancing")
        XCTAssertEqual(session.currentIndex, initialIndex+1, "Index should advance")
        XCTAssertTrue(session.canGoBack, "Session should be able to go back after advancing")
        XCTAssertNotNil(session.goBack(), "Session should return previous card")
        XCTAssertEqual(session.currentIndex, initialIndex, "Session index should be the initial value after advancing and going back")
    }

}
