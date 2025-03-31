//
//  HeroGridItemView.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import Kingfisher
import SwiftUI

struct HeroGridItemView: View {
    let hero: Hero
    
    var body: some View {
        VStack(alignment: .center) {
            KFImage(hero.imageURL)
                .resizable()
            
            Text(hero.name)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .frame(height: 50)
                .padding(.horizontal)
            
            Spacer()
            
        }
        .frame(height: 230)
        .background(.red)
        .clipShape(
            RoundedRectangle(
                cornerSize: CGSize(
                    width: 12,
                    height: 12
                )
            )
        )
        .accessibilityElement(children: .combine)
        .accessibilityIdentifier("heroGridItem")
    }
}
