
import Foundation
import RealmSwift

class Item: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var balance = 0
    @Persisted var dailyExpense = 0
}
