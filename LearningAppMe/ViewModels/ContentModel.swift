//
//  ContentModel.swift
//  LearningAppMe
//
//  Created by adrian garcia on 10/24/22.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    @Published var currentModule: Module?
    @Published var currentLesson: Lesson?
    @Published var currentContentSelected: Int?
    @Published var currentDescription = NSAttributedString()
    
        
    var styleData: Data?
    var currentModuleIndex = 0
    var currentLessonIndex = 0

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
//            moduleId is zero based so the moduleId should always match the modules array index, so you could just use the moduleId to set the module's index like this, modules[moduleId], and it should line up
            if modules[i].id == moduleId {
//                here you could also just set the module's array to the i like this, modules[i] and skip the currentModuleIndex var altogether
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
        currentDescription =  addStyling(currentLesson!.explanation)
    }
    
    func goToNextLesson() {
        
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            currentDescription = addStyling(currentLesson!.explanation)

        } else {
            currentLessonIndex = 0
            currentLesson = nil
        }
        
    }
    
    func hasNextLesson()-> Bool {
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
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
