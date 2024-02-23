//
//  CompetitionsViewModel.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI
import CoreData

final class CompetitionsViewModel: ObservableObject {
    
    @Published var competitions: [CompetitionModel] = []
    @Published var programms: [ProgramModel] = []
    
    @Published var isAddCompetition: Bool = false
    @Published var isAddProgram: Bool = false
    @Published var isDetail: Bool = false
    
    @AppStorage("affiliate_programm") var affiliate_programm: String = ""
    @AppStorage("income_value") var income_value: String = ""
    
    @Published var competition_name: String = ""
    @Published var competition_date: Date = Date()
    @Published var competition_location: String = ""
    @Published var competition_text: String = ""
    
    @Published var program_name: String = ""
    @Published var program_text: String = ""
    
    @Published var currentWindow: WindowsTypes? = nil
    @Published var selectedCompetition: CompetitionModel? = nil
    
    func addCompetition() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let sub = NSEntityDescription.insertNewObject(forEntityName: "CompetitionModel", into: context) as! CompetitionModel
        
        sub.name = competition_name
        sub.date = competition_date
        sub.location = competition_location
        sub.text = competition_text
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchCompetitions() {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CompetitionModel>(entityName: "CompetitionModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.competitions = result
            
        } catch _ as NSError {
            
            self.competitions = []
        }
    }
    
    func addProgram(_ competition_name: String) {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let sub = NSEntityDescription.insertNewObject(forEntityName: "ProgramModel", into: context) as! ProgramModel
        
        sub.name = program_name
        sub.text = program_text
        sub.competition_name = competition_name
        
        CoreDataStack.shared.saveContext()
    }
    
    func fetchPrograms(_ competition_name: String) {
        
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<ProgramModel>(entityName: "ProgramModel")
        
        do {
            
            let result = try context.fetch(fetchRequest)
            
            self.programms = result.filter{$0.competition_name == competition_name}
            
        } catch _ as NSError {
            
            self.programms = []
        }
    }
}

enum WindowsTypes: CaseIterable {
    
    case affiliate, income
    
    var text: String {
        
        switch self {
        case .affiliate:
            return "Affiliate program"
        case .income:
            return "Income"
        }
    }
}
