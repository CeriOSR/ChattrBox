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
    
    func deleteItems(_ item: Items, controllerId: String) {
        var documentsUrl: URL {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
        guard let image = item.imageFileName else {return}
        let imageFilePath = documentsUrl.appendingPathComponent(image)
        do {
            try FileManager.default.removeItem(at: imageFilePath)
            try self.realm.write {
                realm.delete(item)
            }
        } catch {
            alertModels.createAlertWithOneAction("Delete Unsuccessful", message: "Please try to deleting again.")
            return
        }
        if controllerId == "People" {
            var documentsUrl: URL {
                return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            }
            guard let audio = item.audioFileName else {return}
            let audioFilePath = documentsUrl.appendingPathComponent(audio)
            do {
                try FileManager.default.removeItem(at: audioFilePath)
                try self.realm.write {
                    realm.delete(item)
                }
            } catch {
                alertModels.createAlertWithOneAction("Delete Unsuccessful", message: "Please try to deleting again.")
                return
            }
        }
    }
}
