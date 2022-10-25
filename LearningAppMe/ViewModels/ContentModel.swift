//
//  ContentModel.swift
//  LearningAppMe
//
//  Created by adrian garcia on 10/24/22.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var Modules = [Module]()
    
    var htmlData: Data?
    
    init() {
        
        getLocalData()
        
    }
    
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
                
                self.Modules = modules
                
            } catch {
                print("decoder error, \(error)")
            }
        } catch {
            print("try Data() failed, \(error)")
        }
        
        do {
            
            let data = try Data(contentsOf: htmlUrl)
            self.htmlData = data
            
        } catch {
            print("html error, \(error)")
        }
        
    }
}
