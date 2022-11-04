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
                        
                        ForEach(0..<model.currentModule!.content.lessons.count, id: \.self) { i in
                            
                            NavigationLink(value: i) {
                                ContentViewRow(index: i)
                                    .frame(height: 100)
                            }
                            //                        NavigationLink {
                            //                            ContentDetailView()
                            //                                .onAppear {  //make sure stupid .onappears have a trailing closure, if not they dont work
                            //                                    model.getLesson(lessonIndex: i)
                            //                                }
                            //                        } label: {
                            //                            ContentViewRow(index: i)
                            //                                .frame(height: 100)
                            //                        }
                        }
                    }
                }
                .navigationDestination(for: Int.self) { i in
                    ContentDetailView()
                        .onAppear {  //make sure stupid .onappears have a trailing closure, if not they dont work
                            model.getLesson(lessonIndex: i)
                        }
                }
            }
            .padding(.horizontal)
            .tint(.black)
        }
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(ContentModel())
//    }
//}
