
import SwiftUI
import RealmSwift

struct TopicEditorScreen: View {
    @State var text = ""
    @State var item: Topic?
    @State var score = 0.0
    @Environment(\.dismiss) var dismiss
    let vm = TopicViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("text", text: $text)
                    .padding()
                    .font(.custom("SourceSansPro-Black", size: 18))
                    .foregroundColor(Color.black)
//                Slider(
//                    value: $score, 
//                    in: 0...10, 
//                    step: 1,
//                    label: { Text("label") }, 
//                    minimumValueLabel: { Text("0") }, 
//                    maximumValueLabel: { Text("10") })
                Button("save") {
                    if let item = item {
                        vm.update(item, text)
                    } else {
                        vm.save(text)
                    }
                    dismiss()
                }.modifier(MyButtonStyle())
                Spacer()
            }.background(Color.white)
        }.onAppear {
            if let item = item {
                text = item.name
            }
        }
    }    
}

struct TopicEditorScreen_Previews: PreviewProvider {
    static var previews: some View {
        TopicEditorScreen()
    }
}
