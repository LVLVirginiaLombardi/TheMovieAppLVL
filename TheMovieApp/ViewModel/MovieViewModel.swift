//
//  MovieViewModel.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 17/8/24.
//

import Foundation

class MovieViewModel: ObservableObject {
    
    @Published var popularMovies: [DataMovie] = []
    @Published var upcomingMovies: [DataMovie] = []
    @Published var nowPlayingMovies: [DataMovie] = []
    @Published var trendingMovies: [DataMovie] = []
    @Published var ratedMovies: [DataMovie] = []
    @Published private(set) var viewState: ViewState?
    
    var isLoading: Bool {
        viewState == .loading
    }
    
    var isFetching: Bool {
        viewState == .fetching
    }
    
    private var page = 1
    private var totalPages: Int?
    
    init() {
        getPopularMovies()
        getListOfUpcomingMovies()
        getMoviesNowPlaying()
        getMoviesRated()
        getMoviesTrending()
    }
    
    func getPopularMovies() {
        NetworkManager.shared.getPopularMovies { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let movies):
                    self.popularMovies = movies
                    
                case .failure(let error):
                    print("Error fetching popular movies: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func getListOfUpcomingMovies() {
        viewState = .loading
        
        NetworkManager.shared.getLisOfUpcomingMovies(numPage: page) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.viewState = .finished
                
                switch result {
                case .success(let result):
                    self.totalPages = result.total_pages
                    self.upcomingMovies = result.results
                    
                case .failure(let error):
                    print("Error fetching upcoming movies: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func getMoviesNowPlaying() {
        NetworkManager.shared.getMoviesNowPlaying { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let movies):
                    self.nowPlayingMovies = movies
                    
                case .failure(let error):
                    print("Error fetching now playing movies: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func getMoviesRated() {
        NetworkManager.shared.getTopRatedMovies { [weak self] result in
            DispatchQueue.main.async {  
                guard let self = self else { return }
                switch result {
                case .success(let movies):
                    self.ratedMovies = movies
                case .failure(let error):
                    print("Error fetching top rated movies: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func getMoviesTrending() {
        NetworkManager.shared.getMoviesTrending { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let movies):
                    self.trendingMovies = movies
                case .failure(let error):
                    print("Error fetching trending movies: \(error.localizedDescription)")
                }
            }
        }
    }

    @MainActor
    func fetchNextSetOfMovies() async {
        guard page != totalPages else { return }
        
        viewState = .fetching
        defer { viewState = .finished }
        
        page += 1
        
        NetworkManager.shared.getLisOfUpcomingMovies(numPage: page) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let result):
                    self.upcomingMovies.append(contentsOf: result.results)
                    
                case .failure(let error):
                    print("Error fetching next set of movies: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func hasReachedEnd(of movie: DataMovie) -> Bool {
        upcomingMovies.last?.id == movie.id
    }
}

extension MovieViewModel {
    enum ViewState {
        case fetching
        case loading
        case finished
    }
}
