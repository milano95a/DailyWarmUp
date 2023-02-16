
import Foundation
import RealmSwift

class Piece: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted(originProperty: "pieces") var topic: LinkingObjects<Topic>
    @Persisted var text = ""
    @Persisted var image: Data?
}
