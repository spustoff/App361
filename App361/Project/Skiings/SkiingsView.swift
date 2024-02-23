//
//  SkiingsView.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI

struct SkiingsView: View {
    
    @StateObject var viewModel = SkiingsViewModel()
    
    var body: some View {
       
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("Places for skiing")
                        .foregroundColor(.white)
                        .font(.system(size: 26, weight: .semibold))
                    
                    Spacer()
                    
                    if !viewModel.skiings.isEmpty {
                        
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
                
                if viewModel.skiings.isEmpty {
                    
                    VStack(alignment: .center, spacing: 10, content: {
                        
                        Text("Create new places\nskiing")
                            .foregroundColor(.white)
                            .font(.system(size: 19, weight: .semibold))
                            .multilineTextAlignment(.center)
                        
                        Text("Here you can leave places for\nskiing both paid and free")
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
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                            
                            ForEach(viewModel.skiings, id: \.self) { index in
                            
                                VStack(alignment: .leading, spacing: 10, content: {
                                    
                                    Image("ski")
                                        .opacity(index.availability == "Paid" ? 1 : 0)
 
                                    Text(index.name ?? "")
                                        .foregroundColor(.white)
                                        .font(.system(size: 15, weight: .medium))
                                    
                                    HStack {
                                        
                                        ForEach(1...5, id: \.self) { star in
                                      
                                            Image(systemName: index.evaluation >= star ? "star.fill" : "star")
                                                .foregroundColor(.white)
                                                .font(.system(size: 14, weight: .regular))
                                        }
                                    }
                                    
                                    Text("Location: \(index.location ?? "")")
                                        .foregroundColor(.white)
                                        .font(.system(size: 12, weight: .regular))
                                })
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                            }
                        })
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.fetchSkings()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            SkiingsAdd(viewModel: viewModel)
        })
    }
}

#Preview {
    SkiingsView()
}
