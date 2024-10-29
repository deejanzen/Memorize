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
        ScrollView{
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                    
                }
            }
        }
        .foregroundColor(.red)
        .padding()
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: MagicNumbers.rrCornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: MagicNumbers.strokeWidth)
                    Text(card.content).font(font(of: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        })
    }
    
    private func font(of size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * MagicNumbers.fontScale)
    }
    
    private struct MagicNumbers {
        static let fontScale: CGFloat = 0.8
        static let rrCornerRadius: CGFloat = 20
        static let strokeWidth: CGFloat = 3
    }
    
}

#Preview {
    let game = EmojiMemoryGame()
    EmojiMemoryGameView(viewModel: game).preferredColorScheme(.light)
}
