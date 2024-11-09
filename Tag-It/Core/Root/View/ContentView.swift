//
//  ContentView.swift
//  Tag-It
//
//  Created by Aurélien on 09/10/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel

    var body: some View {
        if contentViewModel.isAuthenticated {
            TabBarView()
        } else {
            UserLoginView()
        }
    }
}

#Preview {
    ContentView()
}
