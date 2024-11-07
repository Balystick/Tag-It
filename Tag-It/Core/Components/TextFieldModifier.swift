//
//  TextFieldModifier.swift
//  Tag-It
//
//  Created by Apprenant 124 on 07/11/2024.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
         content
            .padding(10)
            .frame(width: 300)
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 1)
            }
    }
}
