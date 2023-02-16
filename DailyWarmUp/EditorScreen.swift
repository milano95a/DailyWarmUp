
import SwiftUI
import RealmSwift

struct EditorScreen: View {
    @State var balance = ""
    @State var dailyExpense = ""
    @State var item: Item?
    @Environment(\.dismiss) var dismiss
    let vm = ViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .leading) {
                    if balance.isEmpty {
                        Text("balance")
                            .padding()
                            .foregroundColor(Color.gray)
                    }
                    TextField("", text: $balance)
                        .padding()
                        .foregroundColor(.black)
                }
                
                ZStack(alignment: .leading) {
                    if dailyExpense.isEmpty {
                        Text("daily expense")
                            .padding()
                            .foregroundColor(Color.gray)
                    }
                    TextField("", text: $dailyExpense)
                        .padding()
                        .foregroundColor(.black)                    
                }
                
                Button("save") {
                    if let item = item {
                        vm.update(item, balance, dailyExpense)
                    } else {
                        vm.save(balance, dailyExpense)
                    }
                    dismiss()
                }.modifier(MyButtonStyle())
                Spacer()
            }.background(Color.white)
        }.onAppear {
            if let item = item {
                balance = String(item.balance)
                dailyExpense = String(item.dailyExpense)
            }
        }
    }    
}

struct EditorScreen_Previews: PreviewProvider {
    static var previews: some View {
        EditorScreen()
    }
}
