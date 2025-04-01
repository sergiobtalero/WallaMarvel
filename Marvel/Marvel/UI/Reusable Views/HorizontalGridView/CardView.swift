//
//  CardView.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import SwiftUI
import Kingfisher

struct CardView<T: HasThumbnailImage & HasTitle>: View {
    let element: T
    
    var body: some View {
        VStack(alignment: .center) {
            KFImage(element.thumbnailURL)
                .resizable()
                .aspectRatio(1, contentMode: .fill)
                .frame(height: 140)
                .clipped()
            Text(element.title)
                .font(.caption)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(width: 140)
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}
