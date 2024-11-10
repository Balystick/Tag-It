//
//  UserView.swift
//  Tag-It
//
//  Created by Audrey on 23/10/2024.
//
import SwiftUI
import Combine

struct ProfileView: View {
    @EnvironmentObject var contentViewModel: ContentViewModel

    var body: some View {
        VStack(spacing: 0) {
            VStack {
                if let user = contentViewModel.currentUser {
                    VStack {
                        let imageURLString = "http://localhost:8080/users/\(user.image)"
                        if let imageURL = URL(string: imageURLString) {
                            AsyncImage(url: imageURL) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 150, height: 150)
                                        .clipShape(Circle())
                                } else if phase.error != nil {
                                    Text("Erreur de chargement")
                                        .foregroundColor(.red)
                                } else {
                                    ProgressView()
                                }
                            }
                            .frame(width: 150, height: 150)
                            .padding(.top, 20)
                        } else {
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                                .padding(.top, 20)
                        }

                        Text(user.username)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.top, 10)

                        Image("cat.success")
                            .resizable()
                            .frame(width: 100, height: 100)

                        VStack(spacing: 10) {
                            HStack {
                                Image("heart.arrow")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                Text("Oeuvres:")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("23")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            HStack {
                                Image("artist")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                Text("Artistes:")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("12")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            HStack {
                                Image("medal")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                Text("Points:")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("\(user.points)")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            HStack {
                                Image("winner")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                Text("Rang:")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Text("3")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(.top, 20)

                        Spacer()

                        Button(action: {
                            KeychainManager.deleteTokenFromKeychain()
                            contentViewModel.isAuthenticated = false
                            contentViewModel.currentUser = nil
                        }) {
                            Text("Se déconnecter")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                        Spacer()
                    }
                    .padding(20)
                } else {
                    Text("Utilisateur non connecté.")
                        .foregroundColor(.gray)
                }
            }
            Spacer()
        }
        .padding(24)
        .ignoresSafeArea()
    }
}

#Preview {
    ProfileView()
        .environmentObject(ContentViewModel())
}
