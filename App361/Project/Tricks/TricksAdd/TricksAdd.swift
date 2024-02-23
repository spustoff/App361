//
//  TricksAdd.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI

struct TricksAdd: View {
    
    @StateObject var viewModel: TricksViewModel
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New Trick")
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
                                
                                Text("Enter name trick")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                    .opacity(viewModel.name.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.name)
                                    .foregroundColor(.white)
                                    .font(.system(size: 13, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                        })
                        
                        HStack {
                            
                            Text("Complexity")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ForEach(ComplexityTypes.allCases, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.complexity = index
                                    
                                }, label: {
                                    
                                    Text(index.text)
                                        .foregroundColor(index.color)
                                        .font(.system(size: 13, weight: .regular))
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(viewModel.complexity == index ? 0.3 : 0.1)))
                                })
                            }
                            
                            Spacer()
                        }
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            Text("Category")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter category trick")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                    .opacity(viewModel.category.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.category)
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
                                
                                Text("Enter description trick")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                    .opacity(viewModel.text.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.text)
                                    .foregroundColor(.white)
                                    .font(.system(size: 13, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                        })
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            Text("Technic")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter technic trick")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                    .opacity(viewModel.technic.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.technic)
                                    .foregroundColor(.white)
                                    .font(.system(size: 13, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                        })
                        
                        Button(action: {
                            
                            viewModel.addTrick()
                            viewModel.fetchTricks()
                            
                            router.wrappedValue.dismiss()
                            
                            viewModel.name = ""
                            viewModel.complexity = nil
                            viewModel.category = ""
                            viewModel.text = ""
                            viewModel.technic = ""
                        
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary")))
                        })
                        .opacity(viewModel.name.isEmpty || viewModel.complexity == nil || viewModel.category.isEmpty || viewModel.text.isEmpty || viewModel.technic.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.name.isEmpty || viewModel.complexity == nil || viewModel.category.isEmpty || viewModel.text.isEmpty || viewModel.technic.isEmpty ? true : false)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    TricksAdd(viewModel: TricksViewModel())
}
