//
//  SwiftUIView.swift
//  WordsGameWithSwiftUI
//
//  Created by MacBookPro on 28.02.2022.
//

import SwiftUI

struct WordTextField: View {
    
    @State var word: Binding<String>
    var placeHolder: String
    
    var body: some View {
        TextField(placeHolder, text: word)
            .font(.title2)
            .padding()
            .background(Color(.white))
            .cornerRadius(12)
    }
}

//struct SwiftUIView_Previews: PreviewProvider {
//    static var previews: some View {
//        SwiftUIView()
//    }
//}
