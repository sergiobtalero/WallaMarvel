//
//  CharacterDetailView.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import SwiftUI
import Kingfisher

struct CharacterDetailView<VM: CharacterDetailViewModelProtocol>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .idle:
                Color.clear
            case .loading:
                LoadingView()
            case .error:
                ContentUnavailableView("Something failed", systemImage: "exclamationmark.triangle")
            case .loaded(let character):
                CharacterDetailViewWithComicsAndSeries(character: character)
            }
        }
        .padding(.horizontal)
        .marvelNavigationBar()
        .onViewDidLoad {
            Task { await viewModel.loadDetails() }
        }
    }
}

#Preview {
    CharacterDetailView(viewModel: CharacterDetailViewModel(characterId: 10))
}
