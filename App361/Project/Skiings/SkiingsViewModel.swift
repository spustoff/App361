//
//  SkiingsViewModel.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI
import CoreData

final class SkiingsViewModel: ObservableObject {
    
    @Published var skiings: [SkiModel] = []
    
    @Published var isAdd: Bool = false
    
    @Published var name: String = ""
    @Published var availability: String = ""
    @Published var evaluation: Int = 0
    @Published var location: String = ""
    
    func addSki() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let sub = NSEntityDescription.insertNewObject(forEntityName: "SkiModel", into: context) as! SkiModel

        sub.name = name
        sub.availability = availability
        sub.evaluation = Int16(evaluation)
        sub.location = location
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchSkings() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<SkiModel>(entityName: "SkiModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.skiings = result
            
        } catch _ as NSError {
            
            self.skiings = []
        }
    }
}
