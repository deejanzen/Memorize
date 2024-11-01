//
//  AspectVGrid.swift
//  Memorize!
//
//  Created by Dustin Janzen on 10/30/24.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable,ItemView: View>: View {
    
    var items: [Item]
    var aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                var widthFits = widthThatfits(
                    itemCount: items.count,
                    in: geometry.size,
                    itemAspectRatio: aspectRatio
                )
                LazyVGrid(columns: [adaptiveGridItem(width: widthFits)], spacing: 0) {
                    ForEach(items, content: content).aspectRatio(aspectRatio, contentMode: .fit)
                }
                Spacer(minLength: 0)
            }
        }
    }
    
    private func adaptiveGridItem(width: CGFloat) -> GridItem {
        var GridItem = GridItem(.adaptive(minimum: width))
        GridItem.spacing = 0
        return GridItem
    }
    
    private func widthThatfits(itemCount: Int, in size: CGSize, itemAspectRatio: CGFloat ) -> CGFloat {
        var columnCount = 1
        var rowCount = itemCount
        repeat {
            let itemWidth = size.width / CGFloat(columnCount)
            let itemHeight = itemWidth / itemAspectRatio
            if CGFloat(rowCount) * itemHeight < size.height {
                break
            }
            columnCount += 1
            rowCount = (itemCount + (columnCount - 1)) / columnCount
        } while columnCount < itemCount
            if columnCount > itemCount {
                columnCount = itemCount
            }
            return floor(size.width / CGFloat(columnCount))
    }
}

//#Preview {
//    AspectVGrid()
//}
