//
//  HorizontalThumbnailsGrid.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 2/4/25.
//

import Domain
import SwiftUI
import Kingfisher

struct HorizontalThumbnailsGrid<T: Identifiable & HasThumbnailImage>: View {
    private let gridItems: [GridItem] = [GridItem(.flexible())]
    
    let title: String
    let items: [T]
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            Text(title)
                .font(.title3)
                .fontWeight(.heavy)
                .foregroundStyle(.marvelPrimary)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: gridItems) {
                    ForEach(items) { item in
                        KFImage(item.thumbnailURL)
                            .resizable()
                            .placeholder {
                                Color(.accent)
                            }
                            .frame(width: 100, height: 140)
                    }
                }
            }
        }
    }
}
