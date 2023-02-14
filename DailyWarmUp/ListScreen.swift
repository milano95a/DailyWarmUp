
import SwiftUI
import RealmSwift

struct ListScreen: View {
    @ObservedResults(Item.self) var items
    let vm = ListScreenViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if items.count > 0 {
                    List(items) { item in
                        Text(item.name)
                            .font(.custom("SourceSansPro-Black", size: 18))
                            .foregroundColor(.black)
                            .swipeActions(content: {
                                Button("delete") {
                                    vm.delete(item)
                                }
                                NavigationLink(destination: EditorScreen(item: item), label: {
                                    Text("update")
                                })
                            }).listRowBackground(Color.white)
                    }.scrollContentBackground(.hidden)
                } else {
                    Color.clear
                }
                NavigationLink(destination: EditorScreen(), label: {
                    Text("add")
                }).modifier(MyButtonStyle())
            }.background(Color.lightGray)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListScreen()
    }
}

extension Color {
    static var lightGray = Color(red: 240/255, green: 240/255, blue: 240/255)
}
