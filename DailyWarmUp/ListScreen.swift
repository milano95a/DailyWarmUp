
import SwiftUI
import RealmSwift

struct ListScreen: View {
    @ObservedResults(Item.self) var items
    let vm = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("\(items.count)")
                    .frame(height: 1)
                    .hidden()
                if vm.calculate().count > 0 {
                    List(vm.calculate(), id: \.self) { item in
                        VStack {
                            HStack {
                                Text("\(item.date)")
                                Spacer()
                                Text("\(item.days)")
                                Spacer()
                                Text("\(item.remaining)")
                            }
                            VStack {
                                Color.black
                            }.frame(height: 1)
                        }
                        .font(.defaultRegularFont(size: 18))
                        .foregroundColor(.black)
                        .listRowBackground(Color.white)
                        .listRowSeparator(.hidden)
                    }
                    .scrollContentBackground(.hidden)
                } else {
                    Color.clear
                }
                ZStack {
                    NavigationLink(destination: EditorScreen(), label: {
                        Text("add")
                    }).modifier(MyButtonStyle())
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .principal, content: {
                    VStack {
                        Text("Financial Security")
                            .foregroundColor(.black)
                            .font(.defaultFont(size: 20))
                    }                    
                })
            })
            .background(Color.defaultBackground)
        }
    }    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen().onAppear {
//            let realm = try! Realm()
//            try! realm.write {
//                realm.deleteAll()
//            }
//            let item = Item()
//            item.balance = 50_000
//            item.dailyExpense = 300
//            try! realm.write {
//                realm.add(item)
//            }
        }
    }
}

