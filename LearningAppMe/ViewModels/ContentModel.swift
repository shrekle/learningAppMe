//
//  ContentModel.swift
//  LearningAppMe
//
//  Created by adrian garcia on 10/24/22.
//
import SwiftUI
import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
//current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
// current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
// current question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
// current lesson explanation
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
// current selected content and test
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
// navigation stack
    @Published var path = NavigationPath()
    
        

    init() {
        getLocalData()
    }
    
    //MARK: - Data Methods
    func getLocalData() {
        
        //this is how i did it before(it returns a string), this time i will make it into a URL right from the start
//        let pathString = Bundle.main.path(forResource: "data", ofType: ":json")
        let decoder = JSONDecoder()
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        guard let jsonUrl else {return print("json bundle not working")}
        
        let htmlUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        guard let htmlUrl else {return print("html bundle failed")}
        
        do {
            
            let data = try Data(contentsOf: jsonUrl)
            
            do {
                
                let modules = try decoder.decode([Module].self, from: data)
                
                self.modules = modules
                
            } catch {
                print("decoder error, \(error)")
            }
        } catch {
            print("try Data() failed, \(error)")
        }
        
        do {
            
            let data = try Data(contentsOf: htmlUrl)
            styleData = data
            
        } catch {
            print("html error, \(error)")
        }
    }
    
    //MARK: - Module Navigation
    func getModule(moduleId: Int) {
        
        for i in 0..<modules.count {
           
            if modules[i].id == moduleId {
                currentModuleIndex = i
                break
            }
        }
        currentModule = modules[currentModuleIndex]
    }
    
    //MARK: - Lesson Navigation
    func getLesson(lessonIndex: Int) {
        
        if  lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        } else {
            currentLessonIndex = 0
        }
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText =  addStyling(currentLesson!.explanation)
    }
    
    func getTest(moduleId: Int) {
        
        getModule(moduleId: moduleId)
        
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule?.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion?.content ?? "")
        }
    }
    
    func goToNextLesson() {
        
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)

        } else {
            currentLessonIndex = 0
            currentLesson = nil
        }
        
    }
    
    func hasNextLesson()-> Bool {
        return (currentLessonIndex + 1 < currentModule?.content.lessons.count ?? 0)
    }
    
    func nextQuestion() {
        // advance the question index
        currentQuestionIndex += 1
        
        // check that its within the range of questions
        if currentQuestionIndex < currentModule!.test.questions.count {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
        
        // if not then reset then properties
        else {
            currentQuestionIndex = 0
            currentQuestion = nil
        }
        
    }
    
    //MARK: - Code Styling
    
    private func addStyling(_ htmlstring: String)-> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
//        add styling data
        if styleData != nil {
            data.append(styleData!)
        }
//        add HTML data
        data.append(Data(htmlstring.utf8))

//        convert to attributed string
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            resultString = attributedString
        }
        
        return resultString
    }
    
}
