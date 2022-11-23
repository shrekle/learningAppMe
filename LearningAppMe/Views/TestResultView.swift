//
//  TestResultView.swift
//  LearningAppMe
//
//  Created by adrian garcia on 11/22/22.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var numCorrect: Int
    
    var resultHeading: String {
        
        guard model.currentModule != nil else {return ""}
        
        let pct = Double(numCorrect) / Double(model.currentModule!.test.questions.count)
        
        if pct > 0.5 {
            return "Awsome"
        }
        else if pct > 0.2 {
            return " Buck Up Dawg"
        }
        else {
            return "Keep Learning"
        }
        
    }
    
    var body: some View {
        VStack {
            
          Spacer()
            
            Text(resultHeading)
                .font(.title)
            
            Spacer()
            
            Text("You Got \(numCorrect) Out Of \(model.currentModule?.test.questions.count ?? 0) Questions")

            Spacer()
            
            Button {
                
                model.path = NavigationPath()
                
            } label: {
                ZStack {
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    
                    Text("Complete")
                        .bold()
                }
               
            }
            .padding(.horizontal)
            .tint(.white)
            
            Spacer()
            
        }
        
    }
}

//struct TestResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestResultView(numCorrect: 6)
//            .environmentObject(ContentModel())
//    }
//}
