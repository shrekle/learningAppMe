//
//  TestView.swift
//  LearningAppMe
//
//  Created by adrian garcia on 11/7/22.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model: ContentModel
    
    @State private var selectedAnswerIndex: Int?
    @State private var submitted = false
    
    @State private var numCorrect = 0
    
    var body: some View {
        
        VStack {
            if model.currentQuestion != nil {
                VStack(alignment: .leading) {
                    // question number
                    Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    
                    // question
                    CodeTextView()
                    
                    // Answers Button
                    ScrollView {
                        VStack {
                            ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { i in
                                
                                Button {
                                    selectedAnswerIndex = i
                                } label: {
                                    
                                    ZStack {
                                        if submitted == false {
                                            
                                            RectangleCard(color:  (selectedAnswerIndex == i) ? .gray : .white)
                                            
                                        } else {
                                            
                                            if (i == selectedAnswerIndex && i == model.currentQuestion!.correctIndex) || i == model.currentQuestion!.correctIndex {
                                                
                                                RectangleCard(color: .green)
                                                
                                            } else if i == selectedAnswerIndex && i != model.currentQuestion!.correctIndex {
                                                
                                                RectangleCard(color: .red)
                                            } else {
                                                RectangleCard(color: .white)
                                            }
                                        }
                                        Text(model.currentQuestion!.answers[i])
                                    }
                                    .frame(height: 48)
                                    .padding(.horizontal)
                                }
                                .disabled(submitted)
                            }
                        }
                        .tint(.black)
                        .padding(.vertical)
                    }
                    
                    // submit button
                    Button {
                        submitted = true
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                            numCorrect += 1
                        }
                    } label: {
                        ZStack {
                            RectangleCard(color: .green)
                                .frame(height: 48)
                            
                            Text("Submit")
                                .tint(.white)
                                .bold()
                        }
                        .padding(.horizontal)
                    }
                    .disabled(selectedAnswerIndex == nil ? true : false)
                }
            }
            else {
                ProgressView()
            }
        }
        .padding(.horizontal)
        .navigationTitle("\(model.currentModule?.category ?? "") Test")
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .environmentObject(ContentModel())
    }
}
