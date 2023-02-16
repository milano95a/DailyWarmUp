
import Foundation
import RealmSwift

class Topic: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name = ""
    @Persisted var date = Date.now
    @Persisted var pieces = RealmSwift.List<Piece>()
}
