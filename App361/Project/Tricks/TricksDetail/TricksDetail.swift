//
//  TricksDetail.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI

struct TricksDetail: View {
    
    let index: TrickModel
    
    @StateObject var viewModel: TricksViewModel
    
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
                                
                                Text(index.complexity ?? "")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .semibold))
                                
                                Text("Complexity")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                            })
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.1)))
                            
                            VStack(alignment: .leading, spacing: 10, content: {
                                
                                Text(index.category ?? "")
                                    .foregroundColor(.white)
                                    .font(.system(size: 17, weight: .semibold))
                                
                                Text("Category")
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
                            
                            Text("Technic")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .semibold))
                            
                            Text(index.technic ?? "")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                                .multilineTextAlignment(.leading)
                        })
                    }
                    .padding()
                }
            }
        }
    }
}

//#Preview {
//    TricksDetail(index: <#TrickModel#>, viewModel: TricksViewModel())
//}
