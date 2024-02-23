//
//  TricksViewModel.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI
import CoreData

final class TricksViewModel: ObservableObject {
    
    @Published var tricks: [TrickModel] = []
    
    @Published var isAdd: Bool = false
    @Published var isDetail: Bool = false
    
    @Published var name: String = ""
    @Published var complexity: ComplexityTypes? = nil
    @Published var category: String = ""
    @Published var text: String = ""
    @Published var technic: String = ""
    
    @Published var selectedTrick: TrickModel? = nil
    
    func addTrick() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let sub = NSEntityDescription.insertNewObject(forEntityName: "TrickModel", into: context) as! TrickModel

        sub.name = name
        sub.complexity = complexity?.text ?? ""
        sub.category = category
        sub.text = text
        sub.technic = technic
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchTricks() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TrickModel>(entityName: "TrickModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.tricks = result
            
        } catch _ as NSError {
            
            self.tricks = []
        }
    }
}

enum ComplexityTypes: CaseIterable {
    
    case easy, medium, hard
    
    var text: String {
        
        switch self {
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .hard:
            return "Hard"
        }
    }
    
    var color: Color {
        
        switch self {
        case .easy:
            return .green
        case .medium:
            return .yellow
        case .hard:
            return .red
        }
    }
}
