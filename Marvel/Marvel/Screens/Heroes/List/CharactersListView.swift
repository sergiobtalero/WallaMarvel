//
//  CharactersListView.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Domain
import SwiftUI

struct CharactersListView<VM: CharactersListViewModelProtocol>: View {
    enum GridLayout: Int {
        case oneColumn
        case twoColumns
    }
    
    @StateObject private var viewModel: VM
    @EnvironmentObject private var coordinator: AppCoordinator
    @State private var gridLayout: GridLayout = .twoColumns
    @State private var columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    private var leftNavigationBarImageName: String {
        gridLayout != .twoColumns ? "align.vertical.top.fill" : "align.horizontal.left.fill"
    }
    
    // MARK: - Initializer
    init(viewModel: VM = CharactersListViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Body
    var body: some View {
        Group {
            switch viewModel.state {
            case .idle:
                Color.clear
            case .empty:
                ContentUnavailableView("No characters to show", systemImage: "eye.slash")
            case .loading:
                LoadingView()
            case .loaded(let characters):
                Group {
                    if characters.isEmpty {
                        ContentUnavailableView.search
                    } else {
                        ScrollView(showsIndicators: true) {
                            LazyVGrid(columns: columns, alignment: .leading) {
                                
                                ForEach(characters) { character in
                                    CharacterCardView(hero: character)
                                        .onAppear {
                                            viewModel.onCharacterAppear(character)
                                        }
                                        .onTapGesture {
                                            coordinator.push(.characterDetail(character))
                                        }
                                }
                            }
                            .padding(.horizontal)
                            .animation(.linear, value: viewModel.state)
                        }
                    }
                }
                .searchable(
                    text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search hero by name"
                )
            }
        }
        .marvelNavigationBar()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    toggleGridLayout()
                } label: {
                    Image(systemName: leftNavigationBarImageName)
                }
                
            }
        }
        .onViewDidLoad {
            Task { await viewModel.loadFirstPage() }
        }
    }
}

// MARK: - Private
private extension CharactersListView {
    func toggleGridLayout() {
        gridLayout = gridLayout == .oneColumn ? .twoColumns : .oneColumn
        
        withAnimation(.bouncy) {
            columns = Array(repeating: GridItem(.flexible()), count: gridLayout.rawValue + 1)
        }
    }
}

#Preview {
    @Previewable @State var coordinator = AppCoordinator()
    
    CharactersListView(viewModel: CharactersListViewModel())
        .environmentObject(coordinator)
}
