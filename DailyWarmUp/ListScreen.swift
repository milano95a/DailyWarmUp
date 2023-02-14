//
//  ContentView.swift
//  DailyWarmUp
//
//  Created by Workspace on 14/02/23.
//

import SwiftUI
import RealmSwift

struct ListScreen: View {
    @ObservedResults(Item.self) var items
    
    var body: some View {
        NavigationStack {
            VStack {
                List(items) { item in
                    Text(item.name)
                        .swipeActions(content: {
                            Button("delete") {
                                delete(item)
                            }
                            NavigationLink(destination: EditorScreen(item: item), label: {
                                Text("update")
                            })
                        })
                }
                NavigationLink(destination: EditorScreen(), label: {
                    Text("add")
                }).modifier(MyButtonStyle())
            }
        }
    }
    
    func delete(_ item: Item) {
        guard let thawedObj = item.thaw() else { return }
        assert(thawedObj.isFrozen == false)
        guard let thawedRealm = thawedObj.realm else { return }
        try! thawedRealm.write {
            thawedRealm.delete(thawedObj)
        }
    }
    
    func update(_ item: Item) {
        guard let thawedObj = item.thaw() else { return }
        assert(thawedObj.isFrozen == false)
        guard let thawedRealm = thawedObj.realm else { return }
        try! thawedRealm.write {
            thawedObj.name = "\(thawedObj.name) updated"
        }
    }
}

struct EditorScreen: View {
    @State var text = ""
    @State var item: Item?
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("text", text: $text)
                    .padding()
                Button("save") {
                    if let item = item {
                        update(item, text)
                    } else {
                        save(text)
                    }
                }.modifier(MyButtonStyle())
                Spacer()
            }
        }.onAppear {
            if let item = item {
                text = item.name
            }
        }
    }
    
    func update(_ item: Item, _ text: String) {
        guard let thawedObj = item.thaw() else { return }
        assert(thawedObj.isFrozen == false)
        guard let thawedRealm = thawedObj.realm else { return }
        try! thawedRealm.write {
            thawedObj.name = text
        }
    }
    
    func save(_ text: String) {
        let realm = try! Realm()
        let item = Item()
        item.name = text
        try! realm.write {
            realm.add(item)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen()
    }
}

struct MyButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(16)
    }
}
