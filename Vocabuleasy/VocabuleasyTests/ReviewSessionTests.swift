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
        for _ in 0..<20 {
            let card = Card()
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
        XCTAssertTrue(session.isCompleted, "Empty session should be immediately completed")
    }
    
    func testSequence() {
        let session = mockSession!
        let initialIndex = session.currentIndex
        precondition(session.count > 1, "Further tests assume session has cards")
        XCTAssertFalse(session.canAdvance, "Session should not be able to advance when a card hasn't been rated")
        session.cardRated(withRating: .correct)
        XCTAssertTrue(session.canAdvance, "Session should be able to advance when a card has been rated")
        XCTAssertFalse(session.canGoBack, "New sessions should not be able to go back")
        XCTAssertNotNil(session.advance(), "Session should return the next card when advancing")
        XCTAssertEqual(session.currentIndex, initialIndex+1, "Index should advance")
        XCTAssertFalse(session.isCompleted, "Session shouldn't be completed until end is reached")
        XCTAssertTrue(session.canGoBack, "Session should be able to go back after advancing")
        XCTAssertNotNil(session.goBack(), "Session should return previous card")
        XCTAssertEqual(session.currentIndex, initialIndex, "Session index should be the initial value after advancing and going back")
    }
    
    func testDeletionOneCard() {
        let card = Card()
        let session = ReviewSession(cards: [card])
        XCTAssertEqual(session.currentCard!.card, card)
        session.delete(card)
        XCTAssertNil(session.currentCard)
        XCTAssertTrue(session.isCompleted)
        
    }
    
    func testMultipleDeletions() {
        let session = mockSession!
        let countBeforeAdd = session.count
        let expectedCardAfterDeletion = session.cards[1].card
        session.cardRated(atIndex: 0, withRating: .wrong)
        let countAfterAdd = session.count
        XCTAssertEqual(countAfterAdd, countBeforeAdd+1)
        session.delete(session.cards.first!.card)
        let countAfterDelete = session.count
        XCTAssertEqual(countAfterDelete, countBeforeAdd-1)
        XCTAssertEqual(session.currentIndex, 0)
        XCTAssertEqual(session.currentCard!.card, expectedCardAfterDeletion)
    }
}
