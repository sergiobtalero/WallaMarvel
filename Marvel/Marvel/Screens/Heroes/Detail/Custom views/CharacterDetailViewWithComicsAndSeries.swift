//
//  CharacterDetailViewWithComicsAndSeries.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 2/4/25.
//

import Domain
import SwiftUI
import Kingfisher

struct CharacterDetailViewWithComicsAndSeries: View {
    let character: Character
    
    private var hasDescriptionToShow: Bool { !character.description.isEmpty }
    private var hasComics: Bool { !character.comics.isEmpty }
    private var hasSeries: Bool { !character.series.isEmpty }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Text(character.name)
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.primary)
            
            KFImage(character.thumbnailURL)
                .resizable()
                .placeholder {
                    Color(.accent)
                }
                .frame(height: 220)
                .frame(maxWidth: .infinity)
                .cornerRadius(8)
                .shadow(radius: 4)
            
            if hasDescriptionToShow {
                LazyVStack(alignment: .leading) {
                    Text("Description")
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundStyle(.marvelPrimary)
                    
                    Text(character.description)
                        .multilineTextAlignment(.leading)
                        .foregroundStyle(.primary)
                }
                .padding(.top)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            
            if hasComics {
                HorizontalThumbnailsGrid(title: "Comics", items: character.comics)
                .padding(.top)
            }
            
            if hasSeries {
                HorizontalThumbnailsGrid(title: "Series",items: character.series)
            }
        }
    }
}
