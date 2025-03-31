//
//  HeroesListView.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Domain
import SwiftUI

struct HeroesListView<VM: HeroesListViewModelProtocol>: View {
    @StateObject private var viewModel: VM
    @EnvironmentObject private var coordinator: AppCoordinator
    @State private var hasTriggeredPagination = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(viewModel.heroes.indices, id: \.self) { index in
                    HeroGridItemView(hero: viewModel.heroes[index])
                        .onAppear {
                            Task {
                                await checkIfShouldLoadNextPage(currentIndex: index)
                            }
                        }
                        .onTapGesture {
                            viewModel.didSelectHero(viewModel.heroes[index])
                        }
                }
            }
            .padding(.horizontal)
        }
        .onViewDidLoad {
            Task { await viewModel.loadFirstPage() }
        }
        .onChange(of: viewModel.heroSelected, { _, hero in
            if let hero {
                coordinator.goToHeroDetail(hero)
            }
        })
        .onChange(of: coordinator.routes, { _, newValue in
            if newValue.isEmpty {
                viewModel.didSelectHero(nil)
            }
        })
        .navigationTitle(viewModel.navigationTitle)
        .searchable(text: $viewModel.query, placement: .navigationBarDrawer(displayMode: .always))
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
