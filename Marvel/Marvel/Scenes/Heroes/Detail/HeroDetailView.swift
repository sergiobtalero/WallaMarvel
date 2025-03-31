//
//  HeroDetailView.swift
//  Marvel
//
//  Created by Sergio David Bravo Talero on 31/3/25.
//

import Domain
import SwiftUI
import Kingfisher

struct HeroDetailView<VM: HeroDetailViewModelProtocol>: View {
    @StateObject private var viewModel: VM
    
    init(viewModel: VM) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                if let imageURL = viewModel.hero.imageURL {
                    HStack {
                        KFImage(imageURL)
                            .resizable()
                            .frame(width: 150, height: 150)
                        Spacer()
                    }
                }
                if !viewModel.hero.description.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(viewModel.hero.description)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .layoutPriority(1)
                    }
                    .padding(.bottom)
                }
                
                if !viewModel.hero.comics.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Comics")
                            .font(.title2)
                            .fontWeight(.semibold)
                        HorizontalGridView(elements: viewModel.hero.comics)
                            .frame(height: 200)
                    }
                    .padding(.bottom)
                }
                
                if !viewModel.hero.series.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Series")
                            .font(.title2)
                            .fontWeight(.semibold)
                        HorizontalGridView(elements: viewModel.hero.series)
                            .frame(height: 200)
                    }
                    .padding(.bottom)
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle(viewModel.hero.name)
        .onViewDidLoad {
            Task {
                await viewModel.loadDetails()
            }
        }
    }
}
