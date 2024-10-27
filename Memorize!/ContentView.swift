//
//  ContentView.swift
//  Memorize!
//
//  Created by Dustin Janzen on 10/19/24.
//

import SwiftUI

struct ContentView: View {
    var emojis = ["🐻‍❄️","🐽","🐔","🦑" ,"🦞", "🦐" ,"🐠", "🐳","🦈","🦭"]
    @State var emojiCount = 3
    var body: some View {
        VStack {
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self, content: { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    })
                }
            }.foregroundColor(.red)
            Spacer()
            HStack {
                add
                Spacer()
                remove
            }
            .font(.largeTitle)
            .padding()
        }
        .padding()
        
    }
    var add: some View {
        Button {
            if emojiCount < emojis.count {
                emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.app.fill")
        }
    }
    var remove: some View {
        Button {
            if emojiCount > 1 {
                emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.square.fill")
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp = true
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content)
            } else {
                shape.fill()
            }
        }.onTapGesture {
            isFaceUp = !isFaceUp
        }.font(.largeTitle)
    }
}

#Preview {
    ContentView()
}
