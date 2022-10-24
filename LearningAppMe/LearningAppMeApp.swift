//
//  LearningAppMeApp.swift
//  LearningAppMe
//
//  Created by adrian garcia on 10/24/22.
//

import SwiftUI

@main
struct LearningAppMeApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
