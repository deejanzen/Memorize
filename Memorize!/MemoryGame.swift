//
//  MemoryGame.swift
//  Memorize!
//
//  Created by Dustin Janzen on 10/27/24.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: Array<Card>
    private var firstFaceUpIndex: Int? {
        get {
            cards.indices.filter({ cards[$0].isFaceUp}).oneAndOnly
        }
        set {
            cards.indices.forEach({cards[$0].isFaceUp = ($0 == newValue) })
        }
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = Array<Card>()
        // add cards x2
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    mutating func choose(_ card: Card) {
        if let cardIndex = cards.firstIndex(where: { $0.id == card.id }), !cards[cardIndex].isFaceUp,
            !cards[cardIndex].isMatched
        {
            if let unwrappedFaceUpIndex = firstFaceUpIndex {
                if cards[unwrappedFaceUpIndex].content == cards[cardIndex].content  {
                    cards[unwrappedFaceUpIndex].isMatched = true
                    cards[cardIndex].isMatched = true
                }
            } else {
                firstFaceUpIndex = cardIndex
            }
            cards[cardIndex].isFaceUp = true
        }
        //print("cards \n\(cards)")
    }
    
    struct Card: Identifiable{
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        let content: CardContent
        let id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if count == 1 {
            first
        } else {
            nil
        }
    }
}
