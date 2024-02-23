//
//  TricksView.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI

struct TricksView: View {
    
    @StateObject var viewModel = TricksViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Tricks")
                        .foregroundColor(.white)
                        .font(.system(size: 26, weight: .semibold))
                    
                    Spacer()
                    
                    if !viewModel.tricks.isEmpty {
                        
                        Button(action: {
                            
                            viewModel.isAdd = true
                            
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
                
                if viewModel.tricks.isEmpty {
                    
                    VStack(alignment: .center, spacing: 10, content: {
                        
                        Text("Create new tricks")
                            .foregroundColor(.white)
                            .font(.system(size: 19, weight: .semibold))
                            .multilineTextAlignment(.center)
                        
                        Text("Your tricks will be shown here")
                            .foregroundColor(.gray)
                            .font(.system(size: 14, weight: .regular))
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            
                            viewModel.isAdd = true
                            
                        }, label: {
                            
                            Text("Click to create")
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
                            
                            ForEach(viewModel.tricks, id: \.self) { index in
                                
                                Button(action: {
                                    
                                    viewModel.selectedTrick = index
                                    viewModel.isDetail = true
                                    
                                }, label: {
                                    
                                    HStack(alignment: .center) {
                                        
                                        Text(index.complexity ?? "")
                                            .foregroundColor(ComplexityTypes.allCases.first(where: {$0.text == index.complexity ?? ""})?.color ?? .white)
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
        .onAppear {
            
            viewModel.fetchTricks()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            TricksAdd(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            if let index = viewModel.selectedTrick {
                
                TricksDetail(index: index, viewModel: viewModel)
            }
        })
    }
}

#Preview {
    TricksView()
}
