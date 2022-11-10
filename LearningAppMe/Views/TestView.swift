//
//  TestView.swift
//  LearningAppMe
//
//  Created by adrian garcia on 11/7/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        VStack {
            if model.currentQuestion != nil {
                VStack {
                    // question number
                    Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    
                    // question
                    CodeTextView()
                    // answers
                    
                    // button
                }
            }
            else {
                ProgressView()
            }
        }
        .navigationTitle("\(model.currentModule?.category ?? "") Test")
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .environmentObject(ContentModel())
    }
}
