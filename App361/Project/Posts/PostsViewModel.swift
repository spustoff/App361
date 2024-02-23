//
//  PostsViewModel.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI
import CoreData

final class PostsViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    @Published var isAdd: Bool = false
    
    @Published var name: String = ""
    @Published var date: Date = Date()
    @Published var text: String = ""
    
    func addPost() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let sub = NSEntityDescription.insertNewObject(forEntityName: "PostModel", into: context) as! PostModel

        sub.name = name
        sub.date = date
        sub.text = text
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchPosts() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PostModel>(entityName: "PostModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.posts = result
            
        } catch _ as NSError {
            
            self.posts = []
        }
    }
}
