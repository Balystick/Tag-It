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
        NavigationStack {
            VStack {
                Spacer()
                
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                
                Spacer()
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Email")
                            .fontWeight(.semibold)
                        TextField("Entrer votre email", text: $email)
                            .modifier(TextFieldModifier())
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Mot de Passe")
                            .fontWeight(.semibold)
                        SecureField("Entrer votre mot de passe", text: $password)
                            .modifier(TextFieldModifier())
                    }
                }
                .padding(.horizontal, 32)
                
                Spacer()
                
                Button {
                    viewModel.login(email: email, password: password, contentViewModel: contentViewModel)
                } label: {
                    Text("Se connecter")
                        .padding(.horizontal, 80)
                        .padding(.vertical, 10)
                        .foregroundColor(.black)
                }
                .foregroundColor(.black)
                .buttonStyle(.bordered)
                
                Spacer()
                
                NavigationLink {
                    UserRegisterView()
                } label: {
                    Text("Vous n'avez pas de compte ? Enregistrez-vous")
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
        
    }
}

#Preview {
    UserLoginView()
}
