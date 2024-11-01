//
//  ContentView.swift
//  Memorize!
//
//  Created by Dustin Janzen on 10/19/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    var body: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            CardView(card: card).onTapGesture { game.choose(card) }.padding(4)
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
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).padding(4).opacity(0.5)
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
        static let fontScale: CGFloat = 0.75
        static let rrCornerRadius: CGFloat = 10
        static let strokeWidth: CGFloat = 3
    }
    
}

#Preview {
    let game = EmojiMemoryGame()
    EmojiMemoryGameView(game: game).preferredColorScheme(.light)
}
