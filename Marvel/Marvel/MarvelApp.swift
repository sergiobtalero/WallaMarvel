//
//  MarvelApp.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import Domain
import SwiftUI

enum Route: Hashable {
    case detail(hero: Hero)
}

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var routes: [Route] = []
    
    func goToHeroDetail(_ hero: Hero) {
        routes.append(.detail(hero: hero))
    }
}

@main
struct MarvelApp: App {
    @StateObject var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.routes) {
                HeroesListView(viewModel: HeroesListViewModel())
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .detail(let hero):
                            HeroDetailView(viewModel: HeroDetailViewModel(hero: hero))
                        }
                    }
            }
            .environmentObject(coordinator)
        }
    }
}
