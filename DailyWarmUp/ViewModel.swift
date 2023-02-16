
import SwiftUI
import RealmSwift

struct ViewModel {
    @ObservedResults(Item.self) var items 
    
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

    func update(_ item: Item, _ balance: String, _ dailyExpense: String) {
        guard let thawedObj = item.thaw() else { return }
        assert(thawedObj.isFrozen == false)
        guard let thawedRealm = thawedObj.realm else { return }
        do {
            try thawedRealm.write {
                thawedObj.balance = Int(balance) ?? 0
                thawedObj.dailyExpense = Int(dailyExpense) ?? 0
            }
        } catch let error {
            print(error)
        }
    }
    
    func save(_ balance: String, _ dailyExpense: String) {
        do {
            let realm = try Realm()
            let item = Item()
            item.balance = Int(balance) ?? 0
            item.dailyExpense = Int(dailyExpense) ?? 0
            try realm.write {
                realm.add(item)
            }
            print("")
        } catch let error {
            print(error)
        }
    }
    
    func calculate() -> [X] {
        var array = [X]()
        if let item = items.last {
            var date = Date()
            for (index, element) in stride(from: item.balance, to: 0, by: -item.dailyExpense).enumerated() {
                let calendarDate = Calendar.current.date(byAdding: .day, value: index, to: date)
                let calendarComponents = Calendar.current.dateComponents([.day, .month], from: calendarDate!)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "LLL"
                let nameOfMonth = dateFormatter.string(from: calendarDate!)
//                let x = X(date: "\(calendarComponents.day!) \(nameOfMonth) \(index)", remaining: "\(element)")
                let x = X(date: "\(calendarComponents.day!) \(nameOfMonth)", days: "\(index)", remaining: "\(element)")
                array.append(x)
            }
            return array
        }
        return array
    }
}

struct X: Hashable {
    var date = ""
    var days = ""
    var remaining = ""
}
