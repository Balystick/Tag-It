////
////  ProfileView.swift
////  Tag-It
////
////  Created by Apprenant 122 on 10/22/24.
////
//
//
//import SwiftUI
//import Combine // Import Combine for using Publishers
//
//struct ProfileView: View {
//    @State private var progress: Float = 0.7
//    @State private var timeRemaining = 5
//    @State private var selectedImage: UIImage?
//    @State private var showImagePicker = false
//    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    let quests = ["Find 8 french pieces", "Find 2 italian pieces", "Find 7 german pieces"]
//
//    var body: some View {
//        VStack(spacing: 0) {
//            // Profile Header
//            ProfileHeader(selectedImage: $selectedImage, showImagePicker: $showImagePicker)
//
//            // Progress Bar
//            ProgressBar(progress: progress)
//
//            Spacer()
//            HStack(spacing: 20) {
//                                ForEach(0..<3) { _ in
//                                    Circle()
//                                        .fill(Color.white.opacity(0.15))
//                                        .frame(width: 80, height: 80)
//                                }
//                            }.padding()
//            Spacer()
//
//            // Quests and Timer
//            QuestSection(timeRemaining: $timeRemaining, quests: quests, timer: timer)
//
//            Spacer()
//        }
//        .padding(24)
//        .background(Color.gray.ignoresSafeArea())
//        .sheet(isPresented: $showImagePicker) {
//            ImagePicker(image: $selectedImage)
//        }
//    }
//}
//
//// MARK: - Profile Header
//struct ProfileHeader: View {
//    @Binding var selectedImage: UIImage?
//    @Binding var showImagePicker: Bool
//
//    var body: some View {
//        HStack(spacing: 16) {
//            // Profile Image
//            Circle()
//                .fill(Color.white.opacity(0.1))
//                .frame(width: 90, height: 90)
//                .overlay(
//                    Group {
//                        if let image = selectedImage {
//                            Image(uiImage: image)
//                                .resizable()
//                                .scaledToFill()
//                                .clipShape(Circle())
//                        } else {
//                            Text("PP")
//                                .foregroundColor(.white)
//                                .font(.system(size: 20, weight: .bold))
//                        }
//                    }
//                )
//                .onTapGesture {
//                    showImagePicker = true
//                }
//
//            // Profile Info
//            VStack(alignment: .leading, spacing: 4) {
//                Text("Kamil Bourouiba")
//                    .font(.title3)
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//
//                Text("Level 7")
//                    .font(.subheadline)
//                    .foregroundColor(.white.opacity(0.8))
//            }
//
//            Spacer()
//            Spacer()
//            // Badge
//            Text("TOP 1%")
//                .font(.system(size: 12, weight: .bold))
//                .padding(.horizontal, 10)
//                .padding(.vertical, 5)
//                .background(Color.white.opacity(0.15))
//                .foregroundColor(.white)
//                .cornerRadius(12)
//        }
//        .padding(.bottom, 20)
//    }
//}
//
//// MARK: - Progress Bar
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
//
//// MARK: - Quest Section
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
//
//// MARK: - Image Picker
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var image: UIImage?
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//        @Binding var image: UIImage?
//
//        init(image: Binding<UIImage?>) {
//            _image = image
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//            if let selectedImage = info[.originalImage] as? UIImage {
//                image = selectedImage
//            }
//            picker.dismiss(animated: true)
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            picker.dismiss(animated: true)
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(image: $image)
//    }
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        picker.sourceType = .photoLibrary
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//}
//
//// Preview
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
