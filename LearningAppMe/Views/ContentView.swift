//
//  ContentView.swift
//  LearningAppMe
//
//  Created by adrian garcia on 10/26/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            LazyVStack{
                
                VStack(spacing: 10) {
                if model.currentModule != nil {
                    ForEach(0..<model.currentModule!.content.lessons.count) { i in
                        
                        ContentViewRow(index: i)
                            .frame(height: 100)
                    }
                }
            }
        }
            .padding(.horizontal)
        }
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(ContentModel())
//    }
//}
