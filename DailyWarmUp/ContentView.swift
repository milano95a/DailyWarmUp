//
//  ContentView.swift
//  DailyWarmUp
//
//  Created by Workspace on 14/02/23.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    @ObservedResults(Item.self) var items
    
    var body: some View {
        VStack {
            List(items) { item in
                Text(item.name)
                    .swipeActions(content: {
                        Button("delete") {
                            delete(item)
                        }
                        Button("update") {
                            update(item)
                        }
                    })
            }
            Button("add") {
                let item = Item()
                item.name = "item"
                let realm = try! Realm()
                try! realm.write {
                    realm.add(item)
                }
            }.modifier(MyButtonStyle())
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
