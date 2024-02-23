//
//  Edit-End.swift
//  App361
//
//  Created by Вячеслав on 2/23/24.
//

import SwiftUI

extension UIApplication {
    
    public func endEditing() {
        
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
