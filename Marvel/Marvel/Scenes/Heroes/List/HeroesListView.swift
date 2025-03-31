//
//  HeroesListView.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Domain
import SwiftUI
import Kingfisher

struct HeroesListView: View {
    @StateObject private var viewModel = HeroesListViewModel()
    @EnvironmentObject private var coordinator: AppCoordinator
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    private var heroes: [CharacterDataModel] {
        viewModel.filteredHeroes.isEmpty ? viewModel.heroes : viewModel.filteredHeroes
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(heroes) { hero in
                    HeroGridItemView(hero: hero)
                    .onAppear {
                        guard viewModel.filteredHeroes.isEmpty else { return }
                        
                        let targetIndex = heroes.count - 5
                        if targetIndex < heroes.count,
                            heroes[targetIndex] == hero {
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
            .padding(.horizontal)
        }
        .onViewDidLoad {
            Task { await viewModel.fetchHeroes() }
        }
        .navigationTitle(viewModel.navigationTitle)
        .searchable(text: $viewModel.query, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: viewModel.query) { _, newValue in
            viewModel.search(for: newValue)
        }
    }
}
import Domain
struct HeroGridItemView: View {
    let hero: CharacterDataModel

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
    }
}

#Preview {
    NavigationStack{
        HeroesListView()
    }
}
