//
//  FavoriteView.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//

import Foundation
import SwiftUI
import Kingfisher

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()

    var body: some View {
        List(viewModel.favorites) { favorite in
            HStack {
                if let posterPath = favorite.posterPath {
                    KFImage(URL(string: "\(Constants.urlImages)\(posterPath)"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 150)
                        .cornerRadius(8)
                }
                Text(favorite.title ?? "Unknown")
                    .font(.headline)
            }
        }
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}


#Preview {
    FavoritesView()
}
