//
//  MoviesView.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 17/8/24.
//

import SwiftUI
import Kingfisher

struct MoviesView: View {
    
    @StateObject private var viewModel = MovieViewModel()
    
    @State private var selectedSection: MovieSection = .upcoming
    
    enum MovieSection {
        case upcoming, nowPlaying, trendings, rated
    }
    
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("background")
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        HeaderView()
                            .padding(.top, 20)
                        
                        PopularMoviesSection()
                        
                        HStack(spacing: 30) {
                            Button(action: {
                                withAnimation {
                                    selectedSection = .upcoming
                                }
                            }) {
                                Text("Upcoming")
                                    .font(.body)
                                    .foregroundColor(selectedSection == .upcoming ? .blue : .white)
                                    .padding()
                                    .background(selectedSection == .upcoming ? Color.gray.opacity(0.2) : Color.clear)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                withAnimation {
                                    selectedSection = .nowPlaying
                                }
                            }) {
                                Text("Now Playing")
                                    .font(.body)
                                    .foregroundColor(selectedSection == .nowPlaying ? .blue : .white)
                                    .padding()
                                    .background(selectedSection == .nowPlaying ? Color.gray.opacity(0.2) : Color.clear)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                withAnimation {
                                    selectedSection = .rated
                                }
                            }) {
                                Text("Top Rated")
                                    .font(.body)
                                    .foregroundColor(selectedSection == .rated ? .blue : .white)
                                    .padding()
                                    .background(selectedSection == .rated ? Color.gray.opacity(0.2) : Color.clear)
                                    .cornerRadius(10)
                            }
                        }
                        
                        if selectedSection == .upcoming {
                            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                                ForEach(viewModel.upcomingMovies.prefix(6), id: \.id) { movie in
                                    NavigationLink {
                                        MovieDetailView(movie: movie)
                                    } label: {
                                        KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                                            .resizable()
                                            .placeholder { progress in
                                                ProgressView()
                                            }
                                            .cornerRadius(12)
                                            .frame(width: 100, height: 150)
                                    }
                                }
                            }
                        }
                        
                        if selectedSection == .nowPlaying {
                            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                                ForEach(viewModel.nowPlayingMovies.prefix(6), id: \.id) { movie in
                                    NavigationLink {
                                        MovieDetailView(movie: movie)
                                    } label: {
                                        KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                                            .resizable()
                                            .placeholder { progress in
                                                ProgressView()
                                            }
                                            .cornerRadius(12)
                                            .frame(width: 100, height: 150)
                                    }
                                }
                            }
                        }
                        
                        if selectedSection == .rated {
                            LazyVGrid(columns: gridItemLayout, spacing: 20) {
                                ForEach(viewModel.ratedMovies.prefix(6), id: \.id) { movie in
                                    NavigationLink {
                                        MovieDetailView(movie: movie)
                                    } label: {
                                        KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                                            .resizable()
                                            .placeholder { progress in
                                                ProgressView()
                                            }
                                            .cornerRadius(12)
                                            .frame(width: 100, height: 150)
                                    }
                                }
                            }
                        }
                        Text("Trending Movies")
                            .padding(.top, 20)
                            .font(.title2)
                            .foregroundColor(.white)
                        TrendingMoviesSection()
                    }
                }
            }
        }
    }
}

#Preview {
    MoviesView()
}


