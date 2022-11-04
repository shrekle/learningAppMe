//
//  CodeTextView.swift
//  LearningAppMe
//
//  Created by adrian garcia on 11/1/22.
//

import SwiftUI
import WebKit

struct CodeTextView: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
    
    
    func makeUIView(context: Context) -> UITextView {
        
        let textView = UITextView()
        textView.isEditable = false
        
        return textView
    }
    
    func updateUIView(_ textView: UITextView, context: Context) {
        textView.attributedText = model.currentDescription
        
        //set animated to false if yo get wierd behavior when clicking next lesson while its auto sctolling to the top of the scrollview
        textView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
    }
}

struct CodeTextView_Previews: PreviewProvider {
    static var previews: some View {
        CodeTextView()
    }
}
