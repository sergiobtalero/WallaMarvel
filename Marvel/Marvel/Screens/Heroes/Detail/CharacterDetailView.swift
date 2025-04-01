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
        ScrollView {
            VStack(alignment: .leading){
                if let imageURL = viewModel.character.thumbnailURL {
                    HStack {
                        KFImage(imageURL)
                            .resizable()
                            .frame(width: 150, height: 150)
                        Spacer()
                    }
                }
                if !viewModel.character.description.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Description")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text(viewModel.character.description)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .layoutPriority(1)
                    }
                    .padding(.bottom)
                }
                
                if !viewModel.character.comics.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Comics")
                            .font(.title2)
                            .fontWeight(.semibold)
                        HorizontalGridView(elements: viewModel.character.comics)
                            .frame(height: 200)
                    }
                    .padding(.bottom)
                }
                
                if !viewModel.character.series.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Series")
                            .font(.title2)
                            .fontWeight(.semibold)
                        HorizontalGridView(elements: viewModel.character.series)
                            .frame(height: 200)
                    }
                    .padding(.bottom)
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle(viewModel.character.name)
        .onViewDidLoad {
            Task {
                await viewModel.loadDetails()
            }
        }
    }
}
