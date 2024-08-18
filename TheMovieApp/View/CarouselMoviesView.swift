//
//  CarouselMoviesView.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//

import SwiftUI
import Kingfisher

struct CarouselMoviesView: View {
    let title: String?
    let movies: [DataMovie]
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    let gridItemLayout: [GridItem]
    let showsIndicator: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let title = title {
                Text(title)
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(.leading, 10)
            }
            
            ScrollView(.horizontal, showsIndicators: showsIndicator) {
                LazyHGrid(rows: gridItemLayout, spacing: 20) {
                    ForEach(movies, id: \.id) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                            KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                                .resizable()
                                .placeholder {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.gray.opacity(0.5))
                                        ProgressView()
                                    }
                                }
                                .cornerRadius(12)
                                .frame(width: frameWidth, height: frameHeight)
                        }
                    }
                }
                .padding(.leading, 10)
            }
        }
    }
}

#Preview {
    CarouselMoviesView(
        title: "Sample",
        movies: [],
        frameWidth: 120,
        frameHeight: 180,
        gridItemLayout: [GridItem(.flexible())],
        showsIndicator: false
    )
}
