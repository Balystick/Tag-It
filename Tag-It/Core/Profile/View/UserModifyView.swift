//
//  UserModifyView.swift
//  Tag-It
//
//  Created by Audrey on 23/10/2024.
//

import SwiftUI

struct UserModifyView: View {
    
    @State private var selectedImage: UIImage?
    @State private var showImagePicker = false
    
    let headerFont = Font.custom(FontNameManager.Pixel.bold, size: 35)
    let regularTextFont = Font.custom(FontNameManager.Pixel.regular, size: 25)
    
    //Booleens boutons textfield
    @State private var isModify = false
    @State private var isCancel = false
    @State private var isValidate = false
    //Booleens alert textield
    @State private var failedEnterName = false
    @State private var showingAlert = false
    @State private var showAlert = false
    //Clear button x in textfield
    
    //VAR pour valeur nom dans bouton annuler
    @State private var oldName: String = ""
    @State private var newName: String = ""
    
    
    
    var body: some View {
        
        Circle()
            .fill(Color.black.opacity(0.1))
            .frame(width: 150, height: 150)
            .overlay(
                Group {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    } else {
                        Text("+")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                }
            )
            .onTapGesture {
                showImagePicker = true
            }
        
        Text("Kamil Bourouiba")
            .font(headerFont)
            .fontWeight(.bold)
            .foregroundColor(.black)
        
        //        VStack {
        //            // Textfield pour modifier nom profil
        //            if isModify {
        //                TextField("Entrer votre nom", text: $viewModel.utilisateur.nom)
        //                    .font(.caption)
        //                    .foregroundColor(Color(.customMediumGray))
        //                    .textFieldStyle(.roundedBorder)
        //                    .frame(minWidth: 0, maxWidth: 180, minHeight: 0, maxHeight: 30)
        //                    .textContentType(.username)
        //                    .onSubmit {
        //                        isValidate.toggle()
        //                        viewModel.addUtilisateur()
        //                        viewModel.saveName(viewModel.utilisateur.nom)
        //                        isModify = false
        //                    }
        //                HStack {
        //                    Spacer()
        //                    //Bouton annuler et retour au text
        //                    Button(action: {
        //                        viewModel.utilisateur.nom = oldName
        //                        isCancel = true
        //                        isModify = false
        //                    }, label: {
        //                        Text("Annuler")
        //                            .font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
        //                            .fontWeight(/*@START_MENU_TOKEN@*/.thin/*@END_MENU_TOKEN@*/)
        //                            .animation(.easeOut(duration: 0.2), value: isModify)
        //                            .foregroundColor(.gray)
        //                    })
        //
        //                    //Bouton valider et enregistrer nom dans view model et userdefaults
        //                    Button(action: {
        //                        //Ajout contraintes texte avec alerte si pas respectées
        //                        //    Aurélien                                    self.saveName()
        //                        self.failedEnterName = false
        //                        if (self.viewModel.utilisateur.nom.isEmpty || self.viewModel.utilisateur.nom.count < 3){
        //                            showingAlert.toggle()
        //                            self.failedEnterName.toggle()
        //                        } else {
        //                            //Fonction pour garder le nom dans le model utilisateur
        //                            viewModel.addUtilisateur()
        //                            //Fonction pour garder le nom dans les Userdefaults
        //                            newName = viewModel.utilisateur.nom
        //                            viewModel.saveName(newName)
        //                            oldName = viewModel.utilisateur.nom
        //                            isValidate.toggle()
        //                            isModify = false
        //
        //                            if oldName != newName{
        //                                showAlert.toggle()
        //                                isValidate.toggle()
        //                                isModify = false
        //                            }
        //                        }
        //                    }, label: {
        //                        Text("Valider")
        //                            .font(.footnote)
        //                            .fontWeight(/*@START_MENU_TOKEN@*/.thin/*@END_MENU_TOKEN@*/)
        //                            .foregroundColor(Color(.customBlue))
        //                    })
        //                    //Affiche alerte si contraintes pas respectées
        //                    .alert(isPresented: $showingAlert) {
        //                        if self.failedEnterName {
        //                            return Alert(title: Text("Le nom doit contenir au moins trois lettres"), message: Text("Veuillez modifier"), dismissButton: .default(Text("OK")))
        //                        }else {
        //                            return Alert(title: Text("Validé"), message: Text("Changé"), dismissButton: .default(Text("OK")))
        //                        }
        //                    }
        //                    .font(/*@START_MENU_TOKEN@*/.footnote/*@END_MENU_TOKEN@*/)
        //                    .fontWeight(/*@START_MENU_TOKEN@*/.thin/*@END_MENU_TOKEN@*/)
        //                    .scaleEffect(isModify ? 1.2 : 1)
        //                    .animation(.easeOut(duration: 0.2), value: isModify)
        //                }
        //                .padding(.horizontal, 15)
        //            } else {
        //                if viewModel.utilisateur.nom.isEmpty{
        //                    Text("Veuillez entrer votre nom")
        //                        .foregroundColor(Color(.customMediumGray))
        //                        .font(.caption)
        //                } else {
        //                    //Nom profil affiché
        //                    Text(viewModel.utilisateur.nom)
        //                        .multilineTextAlignment(.leading)
        //                        .frame(minWidth: 0, maxWidth: 180, minHeight: 0, maxHeight: 30)
        //                        .overlay(
        //                            RoundedRectangle(cornerRadius: 5)
        //                                .stroke(.gray, lineWidth: 0.2)
        //                                .shadow(radius: 20)
        //                        )
        //                        .shadow(radius: 10)
        //                }
    }
    
    // MARK: - Image Picker
    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var image: UIImage?
        
        class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
            @Binding var image: UIImage?
            
            init(image: Binding<UIImage?>) {
                _image = image
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
                if let selectedImage = info[.originalImage] as? UIImage {
                    image = selectedImage
                }
                picker.dismiss(animated: true)
            }
            
            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true)
            }
        }
        
        func makeCoordinator() -> Coordinator {
            return Coordinator(image: $image)
        }
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            picker.sourceType = .photoLibrary
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
        
        
        
        public func getCustomFontNames() {
            // get each of the font families
            for family in UIFont.familyNames.sorted() {
                let names = UIFont.fontNames(forFamilyName: family)
                // print array of names
                print("Family: \(family) Font names: \(names)")
            }
        }
    }
}
    
public struct FontNameManager {
    //MARK: name of font family
    struct Pixel {
        static let regular = "PixelifySans-Medium"
        static let bold = "PixelifySans-Bold"
        // add rest of the font style names
    }
} 
#Preview {
    UserModifyView()
}
