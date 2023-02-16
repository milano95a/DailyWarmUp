
import SwiftUI
import RealmSwift
import PhotosUI

struct PieceEditorScreen: View {
    @State var topic: Topic
    @State var piece: Piece?
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var text = ""
    private let vm = PieceViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack() {
                    if let imageData = selectedImageData,
                        let uiImage = UIImage(data: imageData), 
                        let image = Image(uiImage: uiImage) {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400, height: 400)
                    }
                                        
                    ZStack {
                        if text.isEmpty {
                            HStack {
                                Text("text...").foregroundColor(.gray)
                                Spacer()
                            }
                        }
                        TextField("text", text: $text)
                            .foregroundColor(.black)
                    }.padding()
                    HStack {
                        PhotosPicker(selection: $selectedItem, label: {
                            Label("Select a photo", systemImage: "photo")
                                .modifier(MyButtonStyle())
                        }).onChange(of: selectedItem) { newValue in
                            Task {
                                selectedImageData = try? await newValue?.loadTransferable(type: Data.self)
                            }
                        }

                        Button("save") {
                            if let data = selectedImageData {
                                vm.save(topic, text, data)                                
                            }
                        }.modifier(MyButtonStyle())                        
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
                }
            }.background(.white)
        }.onAppear {
            
        }
    }
}

struct PieceEditorScreen_PreviewProvider: PreviewProvider {
    @ObservedResults(Topic.self) static var topics
    
    static var previews: some View {
        if let topic = topics.first {
            PieceEditorScreen(topic: topic)
                .preferredColorScheme(.dark)            
        } else {
            Text("No Topic")
        }
    } 
}
