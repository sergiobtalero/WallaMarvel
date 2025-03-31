//
//  HorizontalGridView.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import SwiftUI

struct HorizontalGridView<T: Identifiable & HasThumbnailImage & HasTitle>: View {
    let elements: [T]
    
    let rows = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHGrid(rows: rows, spacing: 16) {
                ForEach(elements) { element in
                    CardView(element: element)
                }
            }
            .padding()
        }
    }
}
