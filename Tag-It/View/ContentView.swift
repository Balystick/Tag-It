//
//  ContentView.swift
//  Tag-It
//
//  Created by Aurélien on 09/10/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = PositionViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isAuthorized {
                // Show location info if authorized
                if let position = viewModel.currentPosition {
                    Text("Latitude: \(position.latitude)")
                    Text("Longitude: \(position.longitude)")
                    Text("Timestamp: \(position.timestamp)")
                } else {
                    Text("Fetching location...")
                }
            } else {
                // If authorization is denied or restricted, inform the user
                Text("Location access denied or restricted. Please enable it in settings.")
                    .font(.headline)
                    .padding()
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

#Preview {
    ContentView()
}
