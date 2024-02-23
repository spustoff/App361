//
//  PostsAdd.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI

struct PostsAdd: View {
    
    @StateObject var viewModel: PostsViewModel
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New post")
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
                                
                                Text("Enter name post")
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
                            
                            Text("Date")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            DatePicker(selection: $viewModel.date, displayedComponents: .date, label: {})
                                .labelsHidden()
                            
                            Spacer()
                        }
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            Text("Description")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter description post")
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
                        
                        Button(action: {
                            
                            viewModel.addPost()
                            viewModel.fetchPosts()
                            
                            router.wrappedValue.dismiss()
                            
                            viewModel.name = ""
                            viewModel.text = ""
                            viewModel.date = Date()
                            
                        }, label: {
                            
                            Text("Add")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("primary")))
                        })
                        .opacity(viewModel.name.isEmpty || viewModel.text.isEmpty ? 0.5 : 1)
                        .disabled(viewModel.name.isEmpty || viewModel.text.isEmpty ? true : false)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    PostsAdd(viewModel: PostsViewModel())
}
