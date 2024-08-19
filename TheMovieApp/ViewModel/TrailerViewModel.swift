//
//  TrailerViewModel.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//

import Foundation

class TrailerViewModel: ObservableObject {
    
    @Published var listOfTrailers: [Trailer] = []
    
    func getTrailers(id: Int) {
        NetworkManager.shared.getListOfTrailers(id: id) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                
                switch result {
                case .success(let trailers):
                    self.listOfTrailers = trailers
                
                case .failure(let error):
                    print("Error \(error)")
                }
            }
        }
    }
}
