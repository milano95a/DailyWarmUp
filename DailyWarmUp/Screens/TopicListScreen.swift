
import SwiftUI
import RealmSwift

struct TopicListScreen: View {
    @ObservedResults(Topic.self) var topics
    let vm = TopicViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if topics.count == 0 {
                    Color.clear
                } else {
                    List(topics) { topic in
                        NavigationLink(destination: PieceListScreen(topic: topic), label: {
                            Text(topic.name)
                                .font(.defaultFont(size: 20))
                                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                                .swipeActions(content: {
                                    Button("delete") {
                                        vm.delete(topic)
                                    }.tint(Color.red)
                                    NavigationLink(destination: TopicEditorScreen(item: topic), label: {
                                        Text("update")
                                    }).tint(Color.blue)
                                })
                        }).listRowBackground(Color.gray)
                    }
                    .scrollContentBackground(.hidden)
                }
                NavigationLink(destination: TopicEditorScreen(), label: {
                    Text("add")
                }).modifier(MyButtonStyle())
            }
            .background(.white)
        }
    }    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TopicListScreen().onAppear {
            let realm = try! Realm()
            try! realm.write {
                realm.deleteAll()
            }
            let topic = Topic()
            topic.name = "Topic 1"
            try! realm.write {
                realm.add(topic)
            }
        }.preferredColorScheme(.dark)
    }
}
