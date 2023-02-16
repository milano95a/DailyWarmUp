//
//  Extensions.swift
//  DailyWarmUp
//
//  Created by Workspace on 16/02/23.
//

import SwiftUI

struct MyButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(16)
            .font(.defaultFont(size: 20))
    }
}
