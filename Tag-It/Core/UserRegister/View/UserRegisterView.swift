//
//  UserRegisterView.swift
//  Tag-It
//
//  Created by Audrey on 06/11/2024.
//

import SwiftUI

struct UserRegisterView: View {
    @Environment(\.dismiss) var dismiss
    @State var viewModel = UserRegisterViewModel()

    var body: some View {
        
        Spacer()
        
        Text("S'enregistrer")
            .font(.largeTitle)
            .fontWeight(.bold)
        
        Spacer()
        
        VStack(alignment: .leading){
            Text("Nom de Profil")
            TextField("john_doe", text: $viewModel.username)
                .padding(10)
                .border(.gray, width: 1)
                .background(.white)
                .frame(width: 300)
                .textInputAutocapitalization(.never)
        }
        .padding()
        
        VStack(alignment: .leading){
            Text("Nom Complet")
            TextField("John Doe", text: $viewModel.name)
                .padding(10)
                .border(.gray, width: 1)
                .background(.white)
                .frame(width: 300)
        }
        .padding()
        
        VStack(alignment: .leading){
            Text("Email")
            TextField("Entrer votre email", text: $viewModel.email)
                .padding(10)
                .border(.gray, width: 1)
                .background(.white)
                .frame(width: 300)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
        }
        .padding()
        
        VStack(alignment: .leading){
            Text("Mot de passe")
            SecureField("Entrer votre mot de passe", text: $viewModel.password)
                .padding(10)
                .border(.gray, width: 1)
                .background(.white)
                .frame(width: 300)
        }
        .padding()
        
        Spacer()
        
        Button {
            Task {
                try await viewModel.registration()
            }
        } label: {
            Text("S'enregistrer")
        }
        .padding(.horizontal, 100)
        .padding(.vertical, 20)
        .foregroundColor(.black)
        .buttonStyle(.bordered)
        
        Button {
            dismiss()
        } label: {
            Text("Vous avez déjà un compte? Connectez-vous")
        }
        .font(.caption)
        .foregroundColor(.blue)
            
        Spacer()
    }
}

#Preview {
    UserRegisterView()
}
