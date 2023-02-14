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
                        .font(.custom("SourceSansPro-Black", size: 18))
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
        do {
            try thawedRealm.write {
                thawedRealm.delete(thawedObj)
            }
        } catch let error {
            print(error)
        }
    }
    
    func update(_ item: Item) {
        guard let thawedObj = item.thaw() else { return }
        assert(thawedObj.isFrozen == false)
        guard let thawedRealm = thawedObj.realm else { return }
        do {
            try thawedRealm.write {
                thawedObj.name = "\(thawedObj.name) updated"
            }
        } catch let error {
            print(error)
        }
    }
}

struct EditorScreen: View {
    @State var text = ""
    @State var item: Item?
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("text", text: $text)
                    .padding()
                    .font(.custom("SourceSansPro-Black", size: 18))
                Button("save") {
                    if let item = item {
                        update(item, text)
                    } else {
                        save(text)
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
    
    func update(_ item: Item, _ text: String) {
        guard let thawedObj = item.thaw() else { return }
        assert(thawedObj.isFrozen == false)
        guard let thawedRealm = thawedObj.realm else { return }
        do {
            try thawedRealm.write {
                thawedObj.name = text
            }
        } catch let error {
            print(error)
        }
    }
    
    func save(_ text: String) {
        do {
            let realm = try Realm()
            let item = Item()
            item.name = text
            try realm.write {
                realm.add(item)
            }
        } catch let error {
            print(error)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen().onAppear {
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
            let item = Item()
            item.name = "preview item"
            try! realm.write {
                realm.add(item)
            }
        }
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
