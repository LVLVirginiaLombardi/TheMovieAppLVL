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
                            .padding(.horizontal, 16)
                        
                        RemoteImageMovie(url: movie.backdrop_path ?? "")
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 140)
                            .cornerRadius(8)
                            .offset(x: 10, y: 50)
                            .shadow(radius: 5)
                    }
                }
                
                Text(movie.title ?? movie.original_title ?? "")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.indigo)
                    .padding(.leading)
                
                Text(movie.overview ?? "")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 16)
                
                HStack {
                    Text("Estreno \(movie.release_date ?? "")")
                        .font(.body)
                    
                    Button(action: {
                        // Agregar a favoritos
                    }, label: {
                        Image(systemName: "heart")
                    })
                }
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
            .onAppear(perform: {
                viewModel.getTrailers(id: movie.id ?? 123)
            })
            .padding(5)
        }
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

