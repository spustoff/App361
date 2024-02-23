//
//  CompetitionAdd.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI

struct CompetitionAdd: View {
    
    @StateObject var viewModel: CompetitionsViewModel
    
    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New Competition")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                    
                    HStack {
                        
                        Button(action: {
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            HStack {
                                
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 16, weight: .regular))
                                
                                Text("Back")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 16, weight: .regular))
                            }
                        })
                        
                        Spacer()
                    }
                }
                .padding()
                .padding(.top)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack(spacing: 20) {
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            Text("Name")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter name competition")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                    .opacity(viewModel.competition_name.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.competition_name)
                                    .foregroundColor(.white)
                                    .font(.system(size: 13, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                        })
                        
                        HStack {
                            
                            Text("Date")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            DatePicker(selection: $viewModel.competition_date, displayedComponents: .date, label: {})
                                .labelsHidden()
                            
                            Spacer()
                        }
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            Text("Location")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter location competition")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                    .opacity(viewModel.competition_location.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.competition_location)
                                    .foregroundColor(.white)
                                    .font(.system(size: 13, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                        })
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            Text("Description")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter description competition")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                    .opacity(viewModel.competition_text.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.competition_text)
                                    .foregroundColor(.white)
                                    .font(.system(size: 13, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                        })
                        
                        Button(action: {
                            
                            viewModel.addCompetition()
                            viewModel.fetchCompetitions()
                            
                            router.wrappedValue.dismiss()
                            
                            viewModel.competition_name = ""
                            viewModel.competition_location = ""
                            viewModel.competition_text = ""
                            viewModel.competition_date = Date()
                            
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary")))
                        })
                        .opacity(viewModel.competition_name.isEmpty || viewModel.competition_location.isEmpty || viewModel.competition_text.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.competition_name.isEmpty || viewModel.competition_location.isEmpty || viewModel.competition_text.isEmpty ? true : false)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    CompetitionAdd(viewModel: CompetitionsViewModel())
}
