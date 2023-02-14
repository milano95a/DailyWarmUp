
import SwiftUI
import RealmSwift

struct ListScreen: View {
    @ObservedResults(Item.self) var items
    let vm = ListScreenViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                List(items) { item in
                    Text(item.name)
                        .font(.custom("SourceSansPro-Black", size: 18))
                        .swipeActions(content: {
                            Button("delete") {
                                vm.delete(item)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen()
    }
}
