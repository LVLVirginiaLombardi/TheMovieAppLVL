//
//  PopularMoviesSection.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 19/8/24.
//

import SwiftUI
import Kingfisher

struct PopularMoviesSection: View {
    @StateObject private var viewModel = MovieViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(viewModel.popularMovies.prefix(10), id: \.id) { movie in
                    NavigationLink {
                        MovieDetailView(movie: movie)
                    } label: {
                        KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                            .resizable()
                            .placeholder { progress in
                                ProgressView()
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(radius: 5, x: 5, y: 5)
                            .frame(width: UIScreen.main.bounds.width - 100, height: 500)
                            .scrollTransition { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1 : 0.2)
                                    .scaleEffect(y: phase.isIdentity ? 1 : 0.7)
                            }
                    }
                }
            }
            .scrollTargetLayout()
        }
        .contentMargins(20, for: .scrollContent)
        .scrollTargetBehavior(.viewAligned)
    }
}

#Preview {
    PopularMoviesSection()
}
