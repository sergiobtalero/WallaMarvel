//
//  HeroesListView.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import SwiftUI
import Kingfisher

struct HeroesListView: View {
    @StateObject private var viewModel = HeroesListViewModel()
    @EnvironmentObject private var coordinator: AppCoordinator
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(viewModel.heroes, id: \.id) { hero in
                    HeroGridItemView(hero: hero)
                    .onAppear {
                        if hero == viewModel.heroes.last {
                            Task {
                                await viewModel.loadNextPage()
                            }
                        }
                    }
                    .onTapGesture {
                        coordinator.goToHeroDetail(id: hero.id)
                    }
                }
            }
        }
        .task {
            await viewModel.fetchHeroes()
        }
        .navigationTitle(viewModel.navigationTitle)
    }
}
import Domain
struct HeroGridItemView: View {
    let hero: CharacterDataModel

    var body: some View {
        VStack {
            KFImage(hero.imageURL)
                .resizable()
                .frame(width: 150, height: 150)
                .padding()
            Text(hero.name)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding([.bottom, .horizontal])
        }
        .background(.red)
        .cornerRadius(15)
    }
}

#Preview {
    NavigationStack{
        HeroesListView()
    }
}
