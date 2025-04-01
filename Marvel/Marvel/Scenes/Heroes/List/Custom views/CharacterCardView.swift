//
//  CharacterCardView.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 1/4/25.
//
//

import Domain
import SwiftUI
import Kingfisher

struct CharacterCardView: View {
    let hero: Character
    
    private enum Constant {
        static let cardHeight: CGFloat = 220
        static let cornerRadius: CGFloat = 4
        static let shadowRadius: CGFloat = 4
        static let defaultPadding: CGFloat = 4
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            KFImage(hero.imageURL)
                .resizable()
            
            Text(hero.name)
                .padding(Constant.defaultPadding)
                .background(.accent)
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .cornerRadius(Constant.cornerRadius)
                .padding([.horizontal, .bottom], Constant.defaultPadding)
                .shadow(color: .accent, radius: Constant.shadowRadius)
        }
        .frame(height: Constant.cardHeight)
        .cornerRadius(Constant.cornerRadius)
        .shadow(radius: Constant.shadowRadius)
    }
}
