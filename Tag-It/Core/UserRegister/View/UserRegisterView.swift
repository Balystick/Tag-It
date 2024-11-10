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
    @EnvironmentObject var contentViewModel: ContentViewModel

    var body: some View {
        VStack {
            Spacer()
            
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
            
            Spacer()
            
            VStack(spacing: 20) {
                VStack(alignment: .leading){
                    Text("Username")
                        .fontWeight(.semibold)
                    TextField("john_doe", text: $viewModel.username)
                        .modifier(TextFieldModifier())
                        .textInputAutocapitalization(.never)
                }
                
                VStack(alignment: .leading){
                    Text("Email")
                        .fontWeight(.semibold)
                    TextField("Entrer votre email", text: $viewModel.email)
                        .modifier(TextFieldModifier())
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                }
                
                VStack(alignment: .leading){
                    Text("Mot de Passe")
                        .fontWeight(.semibold)
                    SecureField("Entrer votre mot de passe", text: $viewModel.password)
                        .modifier(TextFieldModifier())
                }
            }
            .padding(.horizontal, 32)
            
            Spacer()
            
            Button {
                Task {
                    await viewModel.registration(contentViewModel: contentViewModel)
                }
            } label: {
                Text("S'enregistrer")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(.horizontal, 32)
            }
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Text("Vous avez déjà un compte ? Connectez-vous")
            }
            .font(.caption)
            .foregroundColor(.blue)
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .alert(item: $viewModel.errorMessage) { errorMessage in
                   Alert(title: Text("Erreur"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
               }
    }
}

#Preview {
    UserRegisterView()
}
