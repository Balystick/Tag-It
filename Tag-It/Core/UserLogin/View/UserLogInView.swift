//
//  UserLogInView.swift
//  Tag-It
//
//  Created by Audrey on 06/11/2024.
//

import SwiftUI

struct UserLoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @StateObject private var viewModel = UserLoginViewModel()
    @EnvironmentObject private var contentViewModel: ContentViewModel

    var body: some View {
        
        Spacer()
        
        Text("Se connecter")
            .font(.largeTitle)
            .fontWeight(.bold)
        

        VStack(alignment: .leading){
            Text("Email")
            TextField("Veuillez entrer votre email", text: $email)
                .padding(10)
                .shadow(color: .gray, radius: 5, x: 20, y: 20)
                .border(.gray, width: 1)
                .background(.white)
                .frame(width: 300)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
        }
        .padding()
        
        VStack(alignment: .leading){
            Text("Mot de passe")
            SecureField("Veuillez entrer votre mot de passe", text: $password)
                .padding(10)
                .shadow(color: .gray, radius: 5, x: 20, y: 20)
                .border(.gray, width: 1)
                .background(.white)
                .frame(width: 300)
        }
        .padding()
        
        Spacer()
        
        Button(action: {
            viewModel.login(email: email, password: password, contentViewModel: contentViewModel)
        }) {
            Text("Se connecter")
                .padding(.horizontal, 80)
                .padding(.vertical, 10)
                .foregroundColor(.black)
        }
        .foregroundColor(.black)
        .buttonStyle(.bordered)
        
        Button("Vous n'avez pas de compte ? Enregistrez-vous") {
            UserRegisterView()
        }
        .font(.caption)
        .foregroundColor(.blue)
        .padding(.top, 10)
        .alert(item: $viewModel.errorMessage) { errorMessage in
                    Alert(title: Text("Erreur"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
                }
            
        Spacer()
    }
}

#Preview {
    UserLoginView()
}
