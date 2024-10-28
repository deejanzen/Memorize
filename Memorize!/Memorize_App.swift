//
//  Memorize_App.swift
//  Memorize!
//
//  Created by Dustin Janzen on 10/19/24.
//

import SwiftUI

@main
struct Memorize_App: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
