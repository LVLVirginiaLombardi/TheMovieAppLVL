//
//  MovieDetailView.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 17/8/24.
//

import SwiftUI
import Kingfisher
import YouTubeiOSPlayerHelper

struct MovieDetailView: View {
    @StateObject var viewModel = TrailerViewModel()
    @State private var urlSelected = ""
    @State private var showTrailer = false
    
    let movie: DataMovie
    @State private var isFavorite: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ZStack(alignment: .bottomLeading) {
                    if viewModel.listOfTrailers.isEmpty {
                        RemoteImageMovie(url: movie.backdrop_path ?? "")
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 250)
                            .cornerRadius(16)
                            .padding(.horizontal, 16)
                            .shadow(radius: 12)
                    } else {
                        YTWrapper(videoID: "\(viewModel.listOfTrailers[0].key)")
                            .frame(height: 250)
                            .cornerRadius(16)
                            .padding(.top, 40)
                        
                        RemoteImageMovie(url: movie.backdrop_path ?? "placeholder")
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 140)
                            .cornerRadius(8)
                            .offset(x: 10, y: 50)
                            .shadow(radius: 5)
                    }
                }
                HStack(alignment: .top, spacing: 16) {
                    Spacer()
                        .frame(width: 80)
                    VStack(alignment: .leading, spacing: 8) {
                        Text(movie.title ?? movie.original_title ?? "placeholder")
                            .font(.title3)
                            .bold()
                            .foregroundColor(.indigo)
                            .padding(.horizontal, 16)
                    }
                }
                HStack {
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                    Text(viewModel.getYear(from: movie.release_date ?? ""))
                        .font(.body)
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        toggleFavorite()
                    }, label: {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .red : .gray)
                    })
                }
                .padding(.horizontal, 8)
                Text(movie.overview ?? "")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
                
                ScrollView {
                    ForEach(viewModel.listOfTrailers, id: \.key) { trailer in
                        TrailerCellView(urlMovie: movie.backdrop_path ?? "", trailer: trailer)
                            .onTapGesture {
                                self.urlSelected = trailer.key
                                showTrailer = true
                            }
                    }
                }
                .frame(height: 300)
                
                .navigationBarItems(trailing: Button(action: {
                }, label: {
                    Image(systemName: "square.and.arrow.up.fill")
                }))
            }
            .sheet(isPresented: $showTrailer, content: {
                EmptyView()
            })
            .onAppear {
                viewModel.getTrailers(id: movie.id ?? 123)
                isFavorite = FavoriteManager.shared.isFavorite(movie: movie)
            }
            .padding(5)
        }
    }
    
    private func toggleFavorite() {
        if isFavorite {
            FavoriteManager.shared.deleteFavorite(movie: movie)
        } else {
            FavoriteManager.shared.saveFavorite(movie: movie)
        }
        isFavorite.toggle()
    }
}

struct YTWrapper: UIViewRepresentable {
    var videoID: String

    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: videoID)
        return playerView
    }

    func updateUIView(_ uiView: YTPlayerView, context: Context) {
    }
}

#Preview {
    MovieDetailView(movie: MockData.movie)
}

