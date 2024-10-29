//
//  File.swift
//  Memorize!
//
//  Created by Dustin Janzen on 10/27/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    static let emojis = ["🐻‍❄️","🐽","🐔","🦑" ,"🦞", "🦐" ,"🐠", "🐳","🦈","🦭"]
    typealias Card = MemoryGame<String>.Card
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 7){ pairIndex in
            emojis[pairIndex]
        }
    }
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: - Intent(s)
    func choose(_ card: Card){
        model.choose(card)
    }
}
