//
//  MyButtonStyle.swift
//  DailyWarmUp
//
//  Created by Workspace on 14/02/23.
//

import SwiftUI

struct MyButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(16)
    }
}
