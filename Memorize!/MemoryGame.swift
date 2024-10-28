//
//  MemoryGame.swift
//  Memorize!
//
//  Created by Dustin Janzen on 10/27/24.
//

import Foundation

struct MemoryGame<CardContent: Equatable> {
    private(set) var cards: Array<Card>
    var faceUpIndex: Int?
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = Array<Card>()
        // add cards x2
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
    }
    
    mutating func  choose(_ card: Card) {
        if let cardIndex = cards.firstIndex(where: { $0.id == card.id }), !cards[cardIndex].isFaceUp {
            if let unwrappedFaceUpIndex = faceUpIndex {
                if unwrappedFaceUpIndex != cardIndex {
                    if cards[unwrappedFaceUpIndex].content == cards[cardIndex].content  {
                        cards[unwrappedFaceUpIndex].isMatched = true
                        cards[cardIndex].isMatched = true
                    }
                    faceUpIndex = nil
                }
            } else {
                for index in cards.indices {
                    cards[index].isFaceUp = false
                }
                faceUpIndex = cardIndex
            }
            cards[cardIndex].isFaceUp.toggle()
        }
        //print("cards \n\(cards)")
    }
    
    struct Card: Identifiable{
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
