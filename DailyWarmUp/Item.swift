//
//  Product.swift
//  DailyWarmUp
//
//  Created by Workspace on 14/02/23.
//

import Foundation
import RealmSwift

class Item: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name = ""
}
