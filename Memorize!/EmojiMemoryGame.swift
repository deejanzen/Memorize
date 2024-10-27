//
//  File.swift
//  Memorize!
//
//  Created by Dustin Janzen on 10/27/24.
//

import SwiftUI

class EmojiMemoryGamev{
    static let emojis = ["🐻‍❄️","🐽","🐔","🦑" ,"🦞", "🦐" ,"🐠", "🐳","🦈","🦭"]
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4){ pairIndex in
            emojis[pairIndex]
        }
    }
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
}
