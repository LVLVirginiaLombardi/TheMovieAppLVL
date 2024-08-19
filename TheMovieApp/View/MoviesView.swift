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
    
    @State private var showUpcoming = false
    @State private var showNowPlaying = false
    @State private var showTrendings = false
    @State private var showRated = false
    
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        Spacer(minLength: 20)
                        HStack(spacing: 20) {
                            Image(systemName: "popcorn.circle")
                                .foregroundColor(.indigo)
                                .font(.title)
                            Text("What do you want to watch?")
                                .font(.title2)
                                .foregroundColor(.indigo)

                        }
                        .padding(.bottom, 60)
                        
                        VStack(alignment: .leading) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 15) {
                                    ForEach(viewModel.popularMovies.prefix(10), id: \.id) { movie in
                                        NavigationLink {
                                            MovieDetailView(movie: movie)
                                        } label: {
                                            KFImage(URL(string: "\(Constants.urlImages)\(movie.poster_path ?? Constants.placeholder)"))
                                                .resizable()
                                                .placeholder { progress in
                                                    ProgressView()
                                                }
                                                .cornerRadius(12)
                                                .frame(width: 250, height: 335)
                                                .shadow(radius: 3)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.bottom, 20)
                        
                        HStack(spacing: 20) {
                            Button(action: {
                                withAnimation {
                                    showUpcoming.toggle()
                                }
                            }) {
                                Text("Upcoming")
                                    .font(.caption)
                                    .foregroundColor(showUpcoming ? .blue : .black)
                                    .padding()
                                    .background(showUpcoming ? Color.gray.opacity(0.2) : Color.clear)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                withAnimation {
                                    showNowPlaying.toggle()
                                }
                            }) {
                                Text("Now Playing")
                                    .font(.caption)
                                    .foregroundColor(showNowPlaying ? .blue : .black)
                                    .padding()
                                    .background(showNowPlaying ? Color.gray.opacity(0.2) : Color.clear)
                                    .cornerRadius(10)
                            }
                            
                            Button(action: {
                                withAnimation {
                                    showRated.toggle()
                                }
                            }) {
                                Text("Top Rated")
                                    .font(.caption)
                                    .foregroundColor(showRated ? .blue : .black)
                                    .padding()
                                    .background(showRated    ? Color.gray.opacity(0.2) : Color.clear)
                                    .cornerRadius(10)
                            }
                        }
                        
                        if showUpcoming {
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
                        
                        if showNowPlaying {
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
                        
                        if showRated {
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
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }
}

#Preview {
    MoviesView()
}
