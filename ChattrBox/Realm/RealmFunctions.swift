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
    
    func deleteItems(_ item: Items) {
        var documentsUrl: URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
        let imageFilePath = documentsUrl.appendingPathComponent(item.imageFileName!)
        let audioFilePath = documentsUrl.appendingPathComponent(item.audioFileName!)
        do {
            try FileManager.default.removeItem(at: audioFilePath)
            try FileManager.default.removeItem(at: imageFilePath)
            try self.realm.write {
                realm.delete(item)
            }
        } catch let err {
            print("Please handle this error", err)
        }
    }
}
