//
//  MarvelNavigationBar.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 1/4/25.
//

import SwiftUI

struct MarvelNavigationBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .principal) {
                    MarvelLogoView()
                        .frame(width: Constant.width, height: Constant.height)
                }
            }
    }
    
    private enum Constant {
        static let width: CGFloat = 80
        static let height: CGFloat = 35
    }
}

extension View {
    public func marvelNavigationBar() -> some View {
        modifier(MarvelNavigationBar())
    }
}
