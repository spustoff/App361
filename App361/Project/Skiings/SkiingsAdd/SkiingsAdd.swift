//
//  SkiingsAdd.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI

struct SkiingsAdd: View {
    
    @StateObject var viewModel: SkiingsViewModel
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New places skiing")
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
                                
                                Text("Enter name skiing")
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
                            
                            Text("Availability")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ForEach(["Free", "Paid"], id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.availability = index
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        if index == "Paid" {
                                            
                                            Image("ski")
                                        }
                                        
                                        Text(index)
                                            .foregroundColor(.white)
                                            .font(.system(size: 14, weight: .regular))
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(viewModel.availability == index ? 0.4 : 0.1)))
                                })
                            }
                            
                            Spacer()
                        }
                        
                        HStack {
                            
                            Text("Evaluation")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ForEach(1...5, id: \.self) { star in
                                
                                Button(action: {
                                    
                                    viewModel.evaluation = star
                                    
                                }, label: {
                                    
                                    Image(systemName: viewModel.evaluation >= star ? "star.fill" : "star")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .regular))
                                })
                            }
                         
                            Spacer()
                        }
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            Text("Location")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter location skiing")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                                    .opacity(viewModel.location.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.location)
                                    .foregroundColor(.white)
                                    .font(.system(size: 13, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                        })
                        
                        Button(action: {
                            
                            viewModel.addSki()
                            viewModel.fetchSkings()
                            
                            router.wrappedValue.dismiss()
                            
                            viewModel.name = ""
                            viewModel.availability = ""
                            viewModel.evaluation = 0
                            viewModel.location = ""
                            
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary")))
                        })
                        .opacity(viewModel.name.isEmpty || viewModel.availability.isEmpty || viewModel.evaluation == 0 || viewModel.location.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.name.isEmpty || viewModel.availability.isEmpty || viewModel.evaluation == 0 || viewModel.location.isEmpty ? true : false)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    SkiingsAdd(viewModel: SkiingsViewModel())
}
