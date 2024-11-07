//
//  ContentViewModel.swift
//  Tag-It
//
//  Created by Aurélien on 07/11/2024.
//
import Foundation

class ContentViewModel: ObservableObject {
    @Published var isAuthenticated = false

    func login(username: String, password: String) {
        self.isAuthenticated = true
    }
}