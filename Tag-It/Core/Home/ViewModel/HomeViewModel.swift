//
//  HomeViewModel.swift
//  Tag-It
//
//  Created by Audrey on 18/10/2024.


import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var artworks: [Artwork] = []
    
    private let baseURL = "http://10.80.56.128:8080/artworks"
    
    func fetchArtWorks() {
        guard let url = URL(string: baseURL) else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedArtWorks = try JSONDecoder().decode([Artwork].self, from: data)
                    DispatchQueue.main.async {
                        self.artworks = decodedArtWorks
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
            else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }

    func addArtWork(_ artwork: Artwork) {
            guard let url = URL(string: baseURL) else {
                print("Invalid URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            do {
                let data = try JSONEncoder().encode(artwork)
                request.httpBody = data
            } catch {
                print("Error encoding contact: \(error)")
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error adding contact: \(error)")
                    return
                }
                self.fetchArtWorks()
            }.resume()
        }

    
    func updateContact(_ artwork: Artwork) {
            guard let url = URL(string: "\(baseURL)/\(artwork.id)") else {
                print("Invalid URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            do {
                let data = try JSONEncoder().encode(artwork)
                request.httpBody = data
            } catch {
                print("Error encoding contact: \(error)")
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error updating contact: \(error)")
                    return
                }
                self.fetchArtWorks()
            }.resume()
        }

        func deleteContact(_ artwork: Artwork) {
            guard let url = URL(string: "\(baseURL)/\(artwork.id)") else {
                print("Invalid URL")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"

            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error deleting contact: \(error)")
                    return
                }

                self.fetchArtWorks()
            }.resume()
        }



    
}


// Get All
//GET : http://10.80.56.128:3000/artworks
//
// Get 1 contact with id=3
//GET : http://10.80.56.128:3000/artworks/3
//
// Insert Contact (request.httpBody)
//POST : http://10.80.56.128:3000/artworks
//
// Uptade Contact with id=5 with :  (request.httpBody)
//PUT : http://10.80.56.128:3000/artworks/5
//
// Remove contact with id=9
//DELETE : http://10.80.56.128:3000/artworks/9

