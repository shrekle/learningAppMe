//
//  Models.swift
//  LearningAppMe
//
//  Created by adrian garcia on 10/24/22.
//
  
//minute 14

import Foundation

struct Module: Decodable, Identifiable, Hashable {
    
    var id: Int
    var category: String
    var content: Content
    var test: Test
}

struct Content: Decodable, Identifiable, Hashable {
    var id: Int
    var image: String
    var time: String
    var description: String
    var lessons: [Lesson]
}

struct Lesson: Decodable, Identifiable, Hashable {
    var id: Int
    var title: String
    var video: String
    var duration: String
    var explanation: String
    
}

struct Test: Decodable, Identifiable, Hashable {
    var id: Int
    var image: String
    var time: String
    var description: String
    var questions: [ Question]
}

struct Question: Decodable, Identifiable, Hashable {
    var id: Int
    var content: String
    var correctIndex: Int
    var answers: [String]
}
