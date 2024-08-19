//
//  HeaderView.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 19/8/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "popcorn.circle")
                .foregroundColor(.indigo)
                .font(.title)
            Text("What do you want to watch?")
                .font(.title2)
                .foregroundColor(.indigo)
        }
        
    }
}

#Preview {
    HeaderView()
}
