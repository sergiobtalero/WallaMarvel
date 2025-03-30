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
        GridItem(.flexible(), spacing: .zero)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(viewModel.filteredHeroes) { hero in
                    HeroGridItemView(hero: hero)
                    .onAppear {
                        if hero == viewModel.filteredHeroes.last {
                            Task {
                                await viewModel.loadNextPage()
                            }
                        }
//                        guard !viewModel.filteredHeroes.isEmpty else { return }
//                        viewModel.filteredHeroes.count
                    }
                    .onTapGesture {
                        coordinator.goToHeroDetail(id: hero.id)
                    }
                }
            }
            .padding(.horizontal)
        }
        .task {
            await viewModel.fetchHeroes()
        }
        .navigationTitle(viewModel.navigationTitle)
        .searchable(text: $viewModel.query)
        .onChange(of: viewModel.query) { _, newValue in
            viewModel.search(for: newValue)
        }
    }
}
import Domain
struct HeroGridItemView: View {
    let hero: CharacterDataModel

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            KFImage(hero.imageURL)
                .resizable()
            Text(hero.name)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(height: 190)
        .background(.red)
    }
}

#Preview {
    NavigationStack{
        HeroesListView()
    }
}
