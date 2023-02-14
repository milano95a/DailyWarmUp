//
//  EidtorScreen.swift
//  DailyWarmUp
//
//  Created by Workspace on 14/02/23.
//

import SwiftUI
import RealmSwift

struct EditorScreen: View {
    @State var text = ""
    @State var score = 0.0
    @State var item: Item?
    @Environment(\.dismiss) var dismiss
    let vm = ListScreenViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("text", text: $text)
                    .padding()
                    .font(.defaultFont(size: 18))
                    .foregroundColor(.black)

                Slider(
                    value: $score,
                    in: 0...10,
                    step: 1,
                    label: { Text("Score") }, 
                    minimumValueLabel: { 
                        Text("0")
                            .font(.defaultFont(size: 18))
                            .foregroundColor(.black) 
                    }, 
                    maximumValueLabel: { 
                        Text("10")
                            .font(.defaultFont(size: 18))
                            .foregroundColor(.black)
                    }).padding()
                
                Text("\(Int(score))")
                    .font(.defaultFont(size: 18))
                    .foregroundColor(.black)
                
                Spacer()
                
                Button("save") {
                    if let item = item {
                        vm.update(item, text)
                    } else {
                        vm.save(text)
                    }
                    dismiss()
                }.modifier(MyButtonStyle())
            }.background(Color.lightGray)
        }.onAppear {
            if let item = item {
                text = item.name
            }
        }
    }
}

struct EditorScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditorScreen()
    }
}
