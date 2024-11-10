//
//  Tag_ItApp.swift
//  Tag-It
//
//  Created by Aurélien on 09/10/2024.
//

import SwiftUI

@main
struct Tag_ItApp: App {
    @StateObject private var contentViewModel = ContentViewModel()
    @StateObject private var artworkViewModel = ArtworkViewModel()
    @StateObject private var favoriteViewModel = FavoriteViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(contentViewModel)
                .environmentObject(artworkViewModel)
                .environmentObject(favoriteViewModel)
        }
    }
}
