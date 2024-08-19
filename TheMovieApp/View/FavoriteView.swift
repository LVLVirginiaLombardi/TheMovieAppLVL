//
//  FavoriteView.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//


import SwiftUI
import Kingfisher

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()
    
    var body: some View {
        VStack {
            if viewModel.favoriteMovies.isEmpty {
                Image("emptyFavorite")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .padding()
                
                Text("There is no movie yet!")
                    .font(.title)
                    .foregroundColor(.gray)
                Text("Find your favorite movie :)")
                    .font(.body)
                    .foregroundColor(.indigo)
            } else {
                List {
                    ForEach(viewModel.favoriteMovies) { movie in
                        HStack {
                            if let posterPath = movie.poster_path {
                                KFImage(URL(string: "\(Constants.urlImages)\(posterPath)"))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 150)
                                    .cornerRadius(8)
                            }
                            Text(movie.title ?? "Unknown")
                                .font(.headline)
                            
                            Spacer()
                            
                            Button(action: {
                                viewModel.removeFavorite(movie: movie)
                            }) {
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.loadFavoriteMovies()
        }
    }
}
