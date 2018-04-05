//
//  RealmModels.swift
//  ChattrBox
//
//  Created by Rey Cerio on 2018-04-03.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation
import RealmSwift

class ChattrRealm {
    let realm = try! Realm()
    var items : Results<Items>?
    
    func fetchAndFilter(_ type: String) -> Results<Items>{
        let items = realm.objects(Items.self)
        let filteredItems = items.filter("type = '\(type)'")
        return filteredItems
    }
}
