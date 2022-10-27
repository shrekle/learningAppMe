//
//  ContentViewRow.swift
//  LearningAppMe
//
//  Created by adrian garcia on 10/27/22.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var index: Int
    
    var body: some View {
        
        var lesson = model.currentModule?.content.lessons[index]
        
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            HStack(spacing: 30) {
                Text(String(index + 1))
                    .font(.title)
                    .bold()
                
                VStack(alignment: .leading) {
                    Text(lesson?.title ?? "")
                        .font(.title)
                        .bold()
                    Text(lesson?.duration ?? "")
                }
            }
            .padding()
        }
        .navigationTitle("Learn \(model.currentModule?.category ?? "")")
    }
}

//struct ContentViewRow_Previews: PreviewProvider {
//    static var previews: some View {
//
//        ContentViewRow(lesson: ContentModel().modules[0].content.lessons[0])
//            .environmentObject(ContentModel())
//    }
//}
