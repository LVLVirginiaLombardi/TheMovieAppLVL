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
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if !viewModel.listOfTrailers.isEmpty {
                    YTWrapper(videoID: "\(viewModel.listOfTrailers[0].key)")
                        .frame(height: 200)
                        .cornerRadius(12)
                        .padding(.horizontal, 15)
                }
                Text(movie.title ?? movie.original_title ?? "")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.red)
                    .padding(.horizontal, 15)
                
                Text(movie.overview ?? "")
                    .font(.body)
                    .padding(.horizontal, 15)
                
                HStack {
                    Text("Estreno \(movie.release_date ?? "")")
                        .font(.title3)
                    
                    Button(action: {
                        //Agregar favoritos
                    }, label: {
                        Image(systemName: "heart")
                    })
                }
                
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
                
                RemoteImageMovie(url: movie.backdrop_path ?? "")
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .shadow(radius: 12)
                    .cornerRadius(12)
                    .padding(.horizontal, 15)
                
                    .navigationBarItems(trailing: Button(action: {
                    }, label: {
                        Image(systemName: "square.and.row.up.fill")
                    }))
            }
            .sheet(isPresented: $showTrailer, content: {
                EmptyView()
            })
            .onAppear(perform: {
                viewModel.getTrailers(id: movie.id ?? 123)
            })
            .padding(5)
        }
    }
}

struct YTWrapper : UIViewRepresentable {
    var videoID : String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: videoID)
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
    }
}

//import SwiftUI
//import Kingfisher
//import YouTubeiOSPlayerHelper
//
//struct MovieDetailView: View {
//    @StateObject var viewModel = TrailerViewModel()
//    @State private var urlSelected = ""
//    @State private var showTrailer = false
//    @State private var isFavorite = false
//    
//    let movie: DataMovie
//    
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 20) {
//                if !viewModel.listOfTrailers.isEmpty {
//                    YTWrapper(videoID: "\(viewModel.listOfTrailers[0].key)")
//                        .frame(height: 200)
//                        .cornerRadius(12)
//                        .padding(.horizontal, 15)
//                }
//                Text(movie.title ?? movie.original_title ?? "")
//                    .font(.title3)
//                    .bold()
//                    .foregroundColor(.red)
//                    .padding(.horizontal, 15)
//                
//                Text(movie.overview ?? "")
//                    .font(.body)
//                    .padding(.horizontal, 15)
//                
//                HStack {
//                    Text("Estreno \(movie.release_date ?? "")")
//                        .font(.title3)
//                    
//                    Button(action: {
//                        if isFavorite {
//                            FavoriteManager.shared.deleteFavorite(movie: movie)
//                        } else {
//                            FavoriteManager.shared.saveFavorite(movie: movie)
//                        }
//                        isFavorite.toggle()
//                    }) {
//                        Image(systemName: isFavorite ? "heart.fill" : "heart")
//                            .foregroundColor(isFavorite ? .red : .gray)
//                            .font(.largeTitle)
//                    }
//                }
//                
//                ScrollView {
//                    ForEach(viewModel.listOfTrailers, id: \.key) { trailer in
//                        TrailerCellView(urlMovie: movie.backdrop_path ?? "", trailer: trailer)
//                            .onTapGesture {
//                                self.urlSelected = trailer.key
//                                showTrailer = true
//                            }
//                    }
//                }
//                .frame(height: 300)
//                
//                RemoteImageMovie(url: movie.backdrop_path ?? "")
//                    .aspectRatio(contentMode: .fill)
//                    .frame(height: 200)
//                    .shadow(radius: 12)
//                    .cornerRadius(12)
//                    .padding(.horizontal, 15)
//                
//                    .navigationBarItems(trailing: Button(action: {
//                    }, label: {
//                        Image(systemName: "square.and.row.up.fill")
//                    }))
//            }
//            .sheet(isPresented: $showTrailer, content: {
//                EmptyView()
//            })
//            .onAppear(perform: {
//                viewModel.getTrailers(id: movie.id ?? 123)
//                isFavorite = FavoriteManager.shared.fetchFavorites().contains { $0.id == movie.id ?? 0 }
//            })
//            .padding(5)
//        }
//    }
//}
//
//struct YTWrapper : UIViewRepresentable {
//    var videoID : String
//    
//    func makeUIView(context: Context) -> YTPlayerView {
//        let playerView = YTPlayerView()
//        playerView.load(withVideoId: videoID)
//        return playerView
//    }
//    
//    func updateUIView(_ uiView: YTPlayerView, context: Context) {
//    }
//}
