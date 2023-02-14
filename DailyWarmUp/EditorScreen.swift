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
    @State var item: Item?
    @Environment(\.dismiss) var dismiss
    let vm = ListScreenViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("text", text: $text)
                    .padding()
                    .font(.custom("SourceSansPro-Black", size: 18))
                Button("save") {
                    if let item = item {
                        vm.update(item, text)
                    } else {
                        vm.save(text)
                    }
                    dismiss()
                }.modifier(MyButtonStyle())
                Spacer()
            }
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
