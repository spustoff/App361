//
//  PostsView.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI

struct PostsView: View {
    
    @StateObject var viewModel = PostsViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("My posts")
                        .foregroundColor(.white)
                        .font(.system(size: 26, weight: .semibold))
                    
                    Spacer()
                    
                    if !viewModel.posts.isEmpty {
                        
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
                
                if viewModel.posts.isEmpty {
                    
                    VStack(alignment: .center, spacing: 10, content: {
                        
                        Text("Create your first post")
                            .foregroundColor(.white)
                            .font(.system(size: 19, weight: .semibold))
                            .multilineTextAlignment(.center)
                        
                        Text("Write posts about your achievements or\ninteresting facts")
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
                            
                            ForEach(viewModel.posts, id: \.self) { index in
                            
                                VStack(alignment: .leading, spacing: 10, content: {
                                    
                                    Text((index.date ?? Date()).convertDate(format: "MMM d HH:mm"))
                                        .foregroundColor(.gray)
                                        .font(.system(size: 13, weight: .regular))
                                        .multilineTextAlignment(.leading)
                                    
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
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            
            viewModel.fetchPosts()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            PostsAdd(viewModel: viewModel)
        })
    }
}

#Preview {
    PostsView()
}
