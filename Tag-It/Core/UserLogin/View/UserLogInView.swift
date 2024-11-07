//
//  UserLogInView.swift
//  Tag-It
//
//  Created by Audrey on 06/11/2024.
//

import SwiftUI

struct UserLogInView: View {
    var body: some View {
        
        Spacer()
        
        Text("Se connecter")
            .font(.largeTitle)
            .fontWeight(.bold)
        

        
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
        
        Button("Se connecter") {
            
        }
        .padding(.horizontal, 100)
        .padding(.vertical, 20)
        .foregroundColor(.black)
        .buttonStyle(.bordered)
        
        Button("Vous n'avez pas de compte? Enregistrez-vous") {
            UserRegisterView()
        }
        .font(.caption)
        .foregroundColor(.blue)
            
        Spacer()
    }
}

#Preview {
    UserLogInView()
}
