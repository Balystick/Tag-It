//
//  TabBarView.swift
//  Tag-It
//
//  Created by Apprenant 124 on 21/10/2024.
//

import SwiftUI

enum Tab: String {
    case home = "house"
    case map = "mappin.and.ellipse"
    case camera = "camera.viewfinder"
    case favorite = "heart"
    case profile = "person"
}

struct TabBarView: View {
    @State private var selectedTab: Tab = .home
    @StateObject private var favoriteViewModel = FavoriteViewModel()

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(favoriteViewModel: favoriteViewModel)
                .tabItem {
                    Image(systemName: Tab.home.rawValue)
                    Text("Home")
                }
                .tag(Tab.home)
            
            MapView(favoriteViewModel: favoriteViewModel)
                .tabItem {
                    Image(systemName: Tab.map.rawValue)
                    Text("Map")
                }
                .tag(Tab.map)
            
           Text("Camera")
                .tabItem {
                    Image(systemName: Tab.camera.rawValue)
                    Text("Camera")
                }
                .tag(Tab.camera)
            
            FavoriteView(favoriteViewModel: favoriteViewModel)
                .tabItem {
                    Image(systemName: Tab.favorite.rawValue)
                    Text("Favorite")
                }
                .tag(Tab.profile)
            
            ProfileView()
                .tabItem {
                    Image(systemName: Tab.profile.rawValue)
                    Text("Profile")
                }
                .tag(Tab.profile)
        }
    }
}

#Preview {
    TabBarView()
}
