//
//  HeroDetailView.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import SwiftUI

struct HeroDetailView<VM: HeroDetailViewModelProtocol>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onViewDidLoad {
                Task {
                    await viewModel.loadDetails()
                }
            }
    }
}

//#Preview {
//    HeroDetailView(hero: CharacterDataModel()
//}
