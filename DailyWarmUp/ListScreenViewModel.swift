
import Foundation
import RealmSwift

struct ListScreenViewModel {
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
