//
//  HeroesListView.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Domain
import SwiftUI

struct HeroesListView<VM: HeroesListViewModelProtocol>: View {
    enum GridLayout: Int {
        case oneColumn
        case twoColumns
    }
    
    @StateObject private var viewModel: VM
    @EnvironmentObject private var coordinator: AppCoordinator
    @State private var hasTriggeredPagination = false
    
    @State private var gridLayout: GridLayout = .twoColumns
    @State private var columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    private var leftNavigationBarImageName: String {
        gridLayout != .twoColumns ? "align.vertical.top.fill" : "align.horizontal.left.fill"
    }
    
    // MARK: - Initializer
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView(showsIndicators: true) {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 8) {
                ForEach(viewModel.heroes) { hero in
                    CharacterCardView(hero: hero)
                }
            }
            .padding(.horizontal)
        }
        .onViewDidLoad {
            Task { await viewModel.loadFirstPage() }
        }
//        .onChange(of: viewModel.heroSelected, { _, hero in
//            if let hero {
//                coordinator.goToHeroDetail(hero)
//            }
//        })
//        .onChange(of: coordinator.routes, { _, newValue in
//            if newValue.isEmpty {
//                viewModel.didSelectHero(nil)
//            }
//        })
        .searchable(text: $viewModel.query, placement: .navigationBarDrawer(displayMode: .always))
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
    }
}

// MARK: - Private
private extension HeroesListView {
    func checkIfShouldLoadNextPage(currentIndex: Int) async {
        guard !viewModel.isLoading, !hasTriggeredPagination else { return }
        
        let thresholdIndex = Int(Double(viewModel.heroes.count) * 0.9)
        if currentIndex >= thresholdIndex {
            hasTriggeredPagination = true
            await viewModel.loadNextPage()
            hasTriggeredPagination = false
        }
    }
    
    func toggleGridLayout() {
        gridLayout = gridLayout == .oneColumn ? .twoColumns : .oneColumn
        
        withAnimation(.bouncy) {
            columns = Array(repeating: GridItem(.flexible()), count: gridLayout.rawValue + 1)
        }
    }
}

#Preview {
    @Previewable @State var coordinator = AppCoordinator()
    NavigationStack{
        HeroesListView(viewModel: HeroesListViewModel())
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .detail(let id):
                    Text("Detail \(id)")
                }
            }
    }
    .environmentObject(coordinator)
}
