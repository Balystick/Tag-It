//
//  HomeView.swift
//  Tag-It
//
//  Created by Audrey on 21/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    let columns = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns , spacing: 20) {
//                    ForEach()
                }
            }
        }.onAppear(
            perform: viewModel.fetchArtWorks
        )
        
    }
}
    #Preview {
        HomeView()
    }
    

