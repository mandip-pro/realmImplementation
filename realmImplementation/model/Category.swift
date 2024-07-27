//
//  category.swift
//  realmImplementation
//
//  Created by mandip on 27/07/2024.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name:String=""
    let items = List<Item>()
}
