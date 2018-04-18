//
//  RealmModels.swift
//  ChattrBox
//
//  Created by Rey Cerio on 2018-04-03.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class ChattrRealm {
    let realm = try! Realm()
    var items : Results<Items>?
    let alertModels = AlertsModels()
    
    func writingToRealmDB(_ item: Items) {
        try! realm.write {
            realm.add(item)
        }
    }
    
    func fetchAndFilter(_ type: String) -> Results<Items>{
        let items = realm.objects(Items.self)
        let filteredItems = items.filter("type = '\(type)'")
        return filteredItems
    }
    
    func deleteItems(_ item: Items) {
        var documentsUrl: URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
        let imageFilePath = documentsUrl.appendingPathComponent(item.imageFileName!)
        do {
            try FileManager.default.removeItem(at: imageFilePath)
            try self.realm.write {
                realm.delete(item)
            }
        } catch {
            alertModels.createAlertWithOneAction("Delete Unsuccessful", message: "Please try to deleting again.")
            return
        }
    }
}
