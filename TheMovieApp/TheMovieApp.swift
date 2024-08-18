//
//  TheMovieApp.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//

import SwiftUI

@main
struct MoviesDemoApp: App {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    @State var isActive = false
    var body: some Scene {
        WindowGroup {
            if isActive {
                MainTabView()
            } else {
                SplashScreenView(isActive: $isActive)
            }
        }
    }
}
