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

        NavigationStack(path: $model.path) {
            
            VStack(alignment: .leading, spacing: 30) {
                
                Text("What do you want to do today?")
                    .padding(.leading,20)
                
                ScrollView {
                    LazyVStack {
                        
                        ForEach(model.modules) { module in
                            
                            VStack(spacing: 20) {

                                NavigationLink(value: module.content) {

                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, lessonCount: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                        .padding(.top)
                                }
                                
                                NavigationLink(value: module.test) {
                                    HomeViewRow(image: module.test.image, title: "\(module.category)", description: module.test.description, lessonCount: "\(module.test.questions.count) Questions", time: module.test.time)
                                }
                            }
                            .navigationDestination(for: Content.self) { content in
                                ContentView()
                                    .onAppear {
                                        model.getModule(moduleId: module.id)
                                    }
                            }
                            .navigationDestination(for: Test.self) { test in
                                TestView()
                                    .onAppear {
                                        model.getTest(moduleId: module.id)
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .tint(.black)
            }
            .navigationTitle("Get Started")
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
