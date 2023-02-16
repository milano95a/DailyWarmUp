
import SwiftUI
import RealmSwift

struct PieceListScreen: View {
    @ObservedRealmObject var topic: Topic
    let vm = PieceViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if topic.pieces.count == 0 {
                    Color.clear
                } else {
                    List(topic.pieces) { piece in
                        VStack(alignment: .leading) {
                            if let data = piece.image, 
                                let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300)
                                    .cornerRadius(10)
                            }
                            Text(piece.text)
                                .foregroundColor(.black)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .swipeActions(content: {
                            Button("delete") {
                                vm.delete(piece)
                            }.tint(Color.red)
                        })
                    }
                    .scrollContentBackground(.hidden)
                }
                NavigationLink(destination: PieceEditorScreen(topic: topic), label: {
                    Text("add")
                        .modifier(MyButtonStyle())
                })
            }.background(Color(red: 245/255, green: 245/255, blue: 245/255))
        }
    }
}

struct PieceListScren: PreviewProvider {
    
    static var topic: Topic {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        let topic = Topic()
        topic.name = "Topic 1"
        try! realm.write {
            realm.add(topic)
        }
        
        let piece = Piece()
        piece.text = "image"
        try! realm.write {
            topic.pieces.append(piece)
        }
        
        return topic
    }
    
    static var previews: some View {
        PieceListScreen(topic: topic)
            .preferredColorScheme(.dark)
    }
}
