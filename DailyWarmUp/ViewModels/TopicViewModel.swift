
import Foundation
import RealmSwift

struct TopicViewModel {
    @ObservedResults(Topic.self) var topics
    
    func delete(_ item: Topic) {
        guard let thawedObj = item.thaw() else { return }
        assert(thawedObj.isFrozen == false)
        guard let thawedRealm = thawedObj.realm else { return }
        do {
            for piece in thawedObj.pieces {
                try thawedRealm.write {
                    thawedRealm.delete(piece)                    
                }
            }
            try thawedRealm.write {
                thawedRealm.delete(thawedObj)
            }
        } catch let error {
            print(error)
        }
    }

    func update(_ item: Topic, _ text: String) {
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
            let item = Topic()
            item.name = text
            try realm.write {
                realm.add(item)
            }
        } catch let error {
            print(error)
        }
    }

}
