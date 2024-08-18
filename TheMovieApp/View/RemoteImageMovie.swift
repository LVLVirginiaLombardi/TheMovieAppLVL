//
//  RemoteImageMovie.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//

import SwiftUI
import Kingfisher

struct RemoteImageMovie: View {
    var url: String
    
    var body: some View {
        KFImage(URL(string: "\(Constants.urlImages)\(url)"))
            .resizable()
            .placeholder { progress in
                ProgressView()
            }
    }
}
