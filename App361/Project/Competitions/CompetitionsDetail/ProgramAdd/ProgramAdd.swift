//
//  ProgramAdd.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI

struct ProgramAdd: View {
    
    @StateObject var viewModel: CompetitionsViewModel
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New Program")
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
                                
                                Text("Enter name program")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                    .opacity(viewModel.program_name.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.program_name)
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
                                
                                Text("Enter description")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                    .opacity(viewModel.program_text.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.program_text)
                                    .foregroundColor(.white)
                                    .font(.system(size: 13, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                        })
                        
                        Button(action: {
                            
                            viewModel.addProgram(viewModel.selectedCompetition?.name ?? "")
                            viewModel.fetchPrograms(viewModel.selectedCompetition?.name ?? "")
                            
                            router.wrappedValue.dismiss()
                            
                            viewModel.program_name = ""
                            viewModel.program_text = ""
                            
                        }, label: {
                            
                            Text("Save")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary")))
                        })
                        .opacity(viewModel.program_name.isEmpty || viewModel.program_text.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.program_name.isEmpty || viewModel.program_text.isEmpty ? true : false)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ProgramAdd(viewModel: CompetitionsViewModel())
}
