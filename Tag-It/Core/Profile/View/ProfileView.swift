//
//  UserView.swift
//  Tag-It
//
//  Created by Audrey on 23/10/2024.
//

import SwiftUI
import SwiftUI
import Combine // Import Combine for using Publishers

struct ProfileView: View {

    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Profile Header
            ProfileHeader(selectedImage: $selectedImage, showImagePicker: $showImagePicker)
            Spacer()
            Spacer()
            Spacer()
        }
        .padding(24)
        .ignoresSafeArea()
//        .background(Color.gray.ignoresSafeArea())
//        .sheet(isPresented: $showImagePicker) {
//            ImagePicker(image: $selectedImage)
//        }
    }
}

// MARK: - Profile Header
struct ProfileHeader: View {
    @Binding var selectedImage: UIImage?
    @Binding var showImagePicker: Bool
    @StateObject private var profileViewModel = ProfileViewModel()
    
    let headerFont = Font.custom(FontNameManager.Pixel.bold, size: 25)
    let regularTextFont = Font.custom(FontNameManager.Pixel.regular, size: 25)
    
    var body: some View {
        VStack {

//            Image(systemName: "pencil.circle")
//                .renderingMode(.original)
//                .font(.largeTitle)
//                .padding()
//                .foregroundStyle(.blue)
//                .multilineTextAlignment(.trailing)
        
//            Circle()
//                .fill(Color.black.opacity(0.1))
//                .frame(width: 150, height: 150)
//                .overlay(
//                    Group {
//                        if let image = selectedImage {
//                            Image(uiImage: image)
//                                .resizable()
//                                .scaledToFill()
//                                .clipShape(Circle())
//                        } else {
//                            Text("+")
//                                .foregroundColor(.white)
//                                .font(.system(size: 20, weight: .bold))
//                        }
//                    }
//                )
            let defaultImageProfile = "defaultUserImage.jpg"
            let imageURL = URL(string: "http://localhost:8080/users/\(profileViewModel.user?.image ?? defaultImageProfile)")

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
            .padding(.top, 20)
//                .onTapGesture {
//                    showImagePicker = true
//                }

            // Profile Info
            VStack{
                Text(profileViewModel.user?.name ?? "User default")
                    .font(headerFont)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Image("cat.success")
                    .resizable()
                    .frame(width: 150, height: 150)
                    
                VStack{
                    HStack{
                        Spacer()
                        Spacer()
                        Image("heart.arrow")
                            .resizable()
                            .frame(width:50, height: 50)
                        Spacer()
                        Text("Oeuvres:")
                            .font(regularTextFont)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("23")
                            .font(regularTextFont)
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Spacer()
                        Image("artist")
                            .resizable()
                            .frame(width:50, height: 50)
                        Spacer()
                        Text("Artistes:")
                            .font(regularTextFont)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("12")
                            .font(regularTextFont)
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        Spacer()
                    }
                    HStack{
                        Spacer()
                        Spacer()
                        Image("medal")
                            .resizable()
                            .frame(width:50, height: 50)
                        Spacer()
                        Text("Points:")
                            .font(regularTextFont)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("\(profileViewModel.user?.points ?? 0)")
                            .font(regularTextFont)
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        Spacer()

                    }
                    HStack{
                        Spacer()
                        Spacer()
                        Image("winner")
                            .resizable()
                            .frame(width:50, height: 50)
                        Spacer()
                        Text("Rang:")
                            .font(regularTextFont)
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("3")
                            .font(regularTextFont)
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                        Spacer()
                    }
                }
            }
        }
        .padding(20)
        .onAppear {
            profileViewModel.fetchUser(by: UUID(uuidString: "3f223c8d-9e67-4fad-8aca-ae563172b205")!)
        }
    }
}

// MARK: - Progress Bar
//struct ProgressBar: View {
//    var progress: Float
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .leading) {
//                Rectangle()
//                    .fill(Color.white.opacity(0.1))
//                    .frame(height: 12)
//                    .cornerRadius(6)
//
//                Rectangle()
//                    .fill(Color.white.opacity(0.3))
//                    .frame(width: geometry.size.width * CGFloat(progress), height: 12)
//                    .cornerRadius(6)
//            }
//        }
//        .frame(height: 12)
//        .padding(.bottom, 20)
//    }
//}

// MARK: - Quest Section
//struct QuestSection: View {
//    @Binding var timeRemaining: Int
//    let quests: [String]
//    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
//
//    var body: some View {
//        VStack {
//            if timeRemaining == 0 {
//                Text("Finish them all!")
//                    .padding()
//                    .foregroundColor(.white)
//                    .font(.system(size: 20, weight: .bold))
//            } else {
//                Text("New missions in: \(timeRemaining)s")
//                    .onReceive(timer) { _ in
//                        if timeRemaining > 0 {
//                            timeRemaining -= 1
//                        }
//                    }
//                    .padding()
//                    .foregroundColor(.white)
//                    .font(.system(size: 20, weight: .bold))
//            }
//
//            ForEach(quests.indices, id: \.self) { index in
//                HStack {
//                    Text(timeRemaining == 0 ? quests[index] : "Quest loading ...")
//                        .padding()
//                        .foregroundColor(.white)
//                        .font(.system(size: 20, weight: .bold))
//                    Spacer()
//                }
//            }
//        }
//    }
//}


#Preview {
    ProfileView()
}
