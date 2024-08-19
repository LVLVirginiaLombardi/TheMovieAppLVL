//
//  SearchMovieView.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//


import SwiftUI
import Kingfisher

struct SearchMoviesView: View {
    @State private var nameOfMovie = ""
    @StateObject var viewModel = SearchMoviesViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.moviesFounded, id: \.id) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                    MovieRow(movie: movie)
                }
            }
            .navigationTitle("Search Movies")
            .searchable(text: $nameOfMovie, prompt: "Search")
            .onChange(of: nameOfMovie) { newValue in
                viewModel.searchMovie(name: newValue)
            }
        }
    }
}

struct MovieRow: View {
    let movie: DataMovie

    var body: some View {
        HStack {
            KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? "")"))
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 150)
                .clipped()
            
            VStack(alignment: .leading) {
                Text(movie.title ?? "Unknown Title")
                    .font(.caption)
                    .padding(.bottom, 2)
                
                Text("Release Date: \(movie.release_date ?? "Unknown")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Text("Language: \(movie.original_language ?? "")")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 10)
        }
        
    }
}

#Preview {
    SearchMoviesView()
}
