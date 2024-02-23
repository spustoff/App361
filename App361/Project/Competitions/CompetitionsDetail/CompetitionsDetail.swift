//
//  CompetitionsDetail.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI

struct CompetitionsDetail: View {
    
    let index: CompetitionModel
    
    @StateObject var viewModel: CompetitionsViewModel
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Text("Competitions")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold))
                    .padding()
                    .padding(.top)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack(alignment: .leading, spacing: 25) {
                        
                        Text(index.name ?? "")
                            .foregroundColor(.white)
                            .font(.system(size: 19, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            
                            VStack(alignment: .leading, spacing: 10, content: {
                                
                                Text((index.date ?? Date()).convertDate(format: "MMM d"))
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .semibold))
                                
                                Text("Date")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                            })
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                            
                            VStack(alignment: .leading, spacing: 10, content: {
                                
                                Text(index.location ?? "")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .semibold))
                                
                                Text("Location")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                            })
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                        }
                        
                        VStack(alignment: .leading, spacing: 15, content: {
                            
                            Text("Description")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                            
                            Text(index.text ?? "")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .regular))
                                .multilineTextAlignment(.leading)
                        })
                        
                        VStack(alignment: .leading, spacing: 15, content: {
                          
                            HStack(content: {
                                
                                Text("My Program")
                                    .foregroundColor(.white)
                                    .font(.system(size: 19, weight: .semibold))
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    viewModel.isAddProgram = true
                                    
                                }, label: {
                                    
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .bold))
                                })
                            })
                            
                            if viewModel.programms.isEmpty {
                                
                                VStack(alignment: .center, spacing: 10, content: {
                                    
                                    Text("Empty")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .semibold))
                                    
                                    Text("No Any programs")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13, weight: .regular))
                                })
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 30)
                                
                            } else {
                                
                                ForEach(viewModel.programms, id: \.self) { index in
                                
                                    VStack(alignment: .leading, spacing: 5, content: {
                                        
                                        Text(index.name ?? "")
                                            .foregroundColor(.white)
                                            .font(.system(size: 20, weight: .semibold))
                                            .multilineTextAlignment(.leading)
                                        
                                        Text(index.text ?? "")
                                            .foregroundColor(.gray)
                                            .font(.system(size: 15, weight: .regular))
                                            .multilineTextAlignment(.leading)
                                    })
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                                }
                            }
                        })
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $viewModel.isAddProgram, content: {
            
            ProgramAdd(viewModel: viewModel)
        })
        .onAppear {
            
            viewModel.fetchPrograms(viewModel.selectedCompetition?.name ?? "")
        }
    }
}

//#Preview {
//    CompetitionsDetail(viewModel: CompetitionsViewModel())
//}
