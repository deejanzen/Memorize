//
//  ContentView.swift
//  Memorize!
//
//  Created by Dustin Janzen on 10/19/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    var body: some View {
        VStack {
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                            .font(.largeTitle)
                            .onTapGesture {
                                viewModel.choose(card)
                            }
                        
                    }
                }
            }.foregroundColor(.red)
            
            
        }
        .padding()
        
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp && !card.isMatched{
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

#Preview {
    let game = EmojiMemoryGame()
    EmojiMemoryGameView(viewModel: game).preferredColorScheme(.light)
}
