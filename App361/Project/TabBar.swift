//
//  TabBar.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI

struct TabBar: View {
    
    @Binding var selectedTab: Tab
    
    var body: some View {
        
        HStack {
            
            ForEach(Tab.allCases, id: \.self) { index in
                
                Button(action: {
                    
                    selectedTab = index
                    
                }, label: {
                    
                    VStack(alignment: .center, spacing: 8, content: {
                        
                        Image(systemName: index.icon)
                            .foregroundColor(selectedTab == index ? Color("primary") : Color.gray)
                            .font(.system(size: 15, weight: .regular))
                        
                        Text(index.text)
                            .foregroundColor(selectedTab == index ? Color("primary") : Color.gray)
                            .font(.system(size: 12, weight: .regular))
                        
                    })
                    .frame(maxWidth: .infinity)
                })
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 14)
        .padding(.top, 14)
        .padding(.bottom, 28)
        .background(Color("bg"))
    }
}

enum Tab: String, CaseIterable {
    
    case competitions, tricks, places, posts, settings
    
    var text: String {
        
        switch self {
        case .competitions:
            return "Competits"
        case .tricks:
            return "Tricks"
        case .places:
            return "Places"
        case .posts:
            return "My Posts"
        case .settings:
            return "Settings"
        }
    }
    
    var icon: String {
        
        switch self {
        case .competitions:
            return "figure.skating"
        case .tricks:
            return "skateboard.fill"
        case .places:
            return "map.fill"
        case .posts:
            return "list.bullet.rectangle.fill"
        case .settings:
            return "gearshape.fill"
        }
    }
}

#Preview {
    ContentView()
}
