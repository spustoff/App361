//
//  CompetitionsView.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI

struct CompetitionsView: View {
    
    @StateObject var viewModel = CompetitionsViewModel()
    
    var body: some View {
    
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Competitions")
                        .foregroundColor(.white)
                        .font(.system(size: 26, weight: .semibold))
                    
                    Spacer()
                    
                    if !viewModel.competitions.isEmpty {
                        
                        Button(action: {
                            
                            viewModel.isAddCompetition = true
                            
                        }, label: {
                            
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .bold))
                        })
                    }
                }
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                HStack {
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.currentWindow = .income
                        }
                        
                    }, label: {
                        
                        VStack(alignment: .leading, spacing: 20, content: {
                            
                            Text("$\(viewModel.income_value.isEmpty ? "0" : viewModel.income_value)")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .semibold))
                            
                            HStack(content: {
                                
                                Text("Income")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                
                                Spacer()
                                
                                Image(systemName: "pencil")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .regular))
                            })
                        })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                    })
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.currentWindow = .affiliate
                        }
                        
                    }, label: {
                        
                        VStack(alignment: .leading, spacing: 20, content: {
                            
                            Text("$\(viewModel.affiliate_programm.isEmpty ? "0" : viewModel.affiliate_programm)")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .semibold))
                            
                            HStack(content: {
                                
                                Text("Affiliate program")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                
                                Spacer()
                                
                                Image(systemName: "pencil")
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .regular))
                            })
                        })
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                    })
                }
                .padding(.horizontal)
                
                if viewModel.competitions.isEmpty {
                    
                    VStack(alignment: .center, spacing: 10, content: {
                        
                        Text("Create new competition")
                            .foregroundColor(.white)
                            .font(.system(size: 19, weight: .semibold))
                            .multilineTextAlignment(.center)
                        
                        Text("Your competitions will be displayed here")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            
                            viewModel.isAddCompetition = true
                            
                        }, label: {
                            
                            Text("Add Competition")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                                .frame(width: 150, height: 50)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary")))
                        })
                    })
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.competitions, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.selectedCompetition = index
                                    viewModel.isDetail = true
                                    
                                }, label: {
                                    
                                    HStack(alignment: .center) {
                                        
                                        Text((index.date ?? Date()).convertDate(format: "MMM d"))
                                            .foregroundColor(.white)
                                            .font(.system(size: 14, weight: .regular))
                                            .frame(maxHeight: .infinity, alignment: .center)
                                        
                                        Divider()
                                        
                                        VStack(alignment: .leading, spacing: 10, content: {
                                            
                                            Text(index.name ?? "")
                                                .foregroundColor(.white)
                                                .font(.system(size: 18, weight: .semibold))
                                                .multilineTextAlignment(.leading)
                                            
                                            Text(index.text ?? "")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 14, weight: .regular))
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(2)
                                        })
                                        
                                        Spacer()
                                    }
                                    .frame(height: 70)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                                })
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .overlay (
        
            ZStack {
                
                Color.black.opacity(viewModel.currentWindow == nil ? 0 : 0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.currentWindow = nil
                        }
                        
                        UIApplication.shared.endEditing()
                    }
                
                VStack {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray.opacity(0.2))
                        .frame(width: 50, height: 5)
                    
                    Text("Edit \(viewModel.currentWindow?.text ?? "")")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .semibold))
                        .padding(.vertical)
                    
                    VStack(alignment: .leading, spacing: 10, content: {
                        
                        Text("\(viewModel.currentWindow?.text ?? "")")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                        
                        ZStack {
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter amount")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                    .opacity(viewModel.income_value.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.income_value)
                                    .foregroundColor(.white)
                                    .font(.system(size: 13, weight: .regular))
                                    .keyboardType(.decimalPad)
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                            .opacity(viewModel.currentWindow == .income ? 1 : 0)
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter amount")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                    .opacity(viewModel.affiliate_programm.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.affiliate_programm)
                                    .foregroundColor(.white)
                                    .font(.system(size: 13, weight: .regular))
                                    .keyboardType(.decimalPad)
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                            .opacity(viewModel.currentWindow == .affiliate ? 1 : 0)
                        }
                    })
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.currentWindow = nil
                        }
                        
                        UIApplication.shared.endEditing()
                        
                    }, label: {
                        
                        Text("Save")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary")))
                    })
                    .padding(.top)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg")).ignoresSafeArea())
                .frame(maxHeight: .infinity, alignment: .bottom)
                .offset(y: viewModel.currentWindow == nil ? UIScreen.main.bounds.height : 0)
            }
        )
        .onAppear {
            
            viewModel.fetchCompetitions()
        }
        .sheet(isPresented: $viewModel.isAddCompetition, content: {
            
            CompetitionAdd(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            if let index = viewModel.selectedCompetition {
                
                CompetitionsDetail(index: index, viewModel: viewModel)
            }
        })
    }
}

#Preview {
    CompetitionsView()
}
