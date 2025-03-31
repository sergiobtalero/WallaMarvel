//
//  MarvelApp.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 30/3/25.
//

import SwiftUI

enum Route: Hashable {
    case detail(id: Int)
}

@MainActor
final class AppCoordinator: ObservableObject {
    @Published var routes: [Route] = []
    
    func goToHeroDetail(id: Int) {
        routes.append(.detail(id: id))
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
                        case .detail(let id):
                            Text("Detail \(id)")
                        }
                    }
            }
            .environmentObject(coordinator)
        }
    }
}
