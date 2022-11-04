//
//  HomeView.swift
//  LearningAppMe
//
//  Created by adrian garcia on 10/24/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        NavigationStack() {
            
            VStack(alignment: .leading, spacing: 30) {
                
                Text("What do you want to do today?")
                    .padding(.leading,20)
                
                ScrollView {
                    LazyVStack {
                        
                        ForEach(model.modules) { module in
                            
                            VStack(spacing: 20) {
                                
                                NavigationLink("chale", tag: module.id, selection: $model.currentContentSelected) {
                                    ContentView()
                                        .onAppear {
                                            model.getModule(moduleId: module.id)
                                        }
                                }
                                
                                
                                NavigationLink {
                                    ContentView()
                                        .onAppear {
                                            model.getModule(moduleId: module.id)
                                        }
                                } label: {
                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, lessonCount: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                }
                                
                                HomeViewRow(image: module.test.image, title: "\(module.category)", description: module.test.description, lessonCount: "\(module.test.questions.count) Questions", time: module.test.time)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .tint(.black)
                }
            }
            .navigationTitle("Get Started")
        }
//        .navigationViewStyle(.stack)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
