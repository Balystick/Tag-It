//
//  UserRegisterView.swift
//  Tag-It
//
//  Created by Audrey on 06/11/2024.
//

import SwiftUI

struct UserRegisterView: View {
    var body: some View {
        
        Spacer()
        
        Text("S'enregistrer")
            .font(.largeTitle)
            .fontWeight(.bold)
        
        Spacer()
        
        VStack(alignment: .leading){
            Text("Nom Complet")
            TextField("Veuillez entrer votre nom complet", text: .constant(""))
                .padding(10)
                .shadow(color: .gray, radius: 5, x: 20, y: 20)
                .border(.gray, width: 1)
                .background(.white)
                .frame(width: 300)
        }
        .padding()
        
        VStack(alignment: .leading){
            Text("Nom de profil")
            TextField("Veuillez entrer votre nom de profil", text: .constant(""))
                .padding(10)
                .shadow(color: .gray, radius: 5, x: 20, y: 20)
                .border(.gray, width: 1)
                .background(.white)
                .frame(width: 300)
        }
        .padding()
        
        VStack(alignment: .leading){
            Text("Email")
            TextField("Veuillez entrer votre email", text: .constant(""))
                .padding(10)
                .shadow(color: .gray, radius: 5, x: 20, y: 20)
                .border(.gray, width: 1)
                .background(.white)
                .frame(width: 300)
        }
        .padding()
        
        VStack(alignment: .leading){
            Text("Mot de passe")
            TextField("Veuillez entrer votre mot de passe", text: .constant(""))
                .padding(10)
                .shadow(color: .gray, radius: 5, x: 20, y: 20)
                .border(.gray, width: 1)
                .background(.white)
                .frame(width: 300)
        }
        .padding()
        
        Spacer()
        
        Button("S'enregistrer") {
            
        }
        .padding(.horizontal, 100)
        .padding(.vertical, 20)
        .foregroundColor(.black)
        .buttonStyle(.bordered)
        
        Button("Vous avez déjà un compte? Connectez-vous") {
            UserLogInView()
        }
        .font(.caption)
        .foregroundColor(.blue)
            
        Spacer()
    }
}

#Preview {
    UserRegisterView()
}
