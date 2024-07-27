//
//  Item.swift
//  realmImplementation
//
//  Created by mandip on 27/07/2024.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title:String=""
    @objc dynamic var done:Bool=false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")

}
