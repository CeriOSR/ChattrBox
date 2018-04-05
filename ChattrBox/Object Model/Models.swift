//
//  File.swift
//  Let's Chat
//
//  Created by Rey Cerio on 2018-03-30.
//  Copyright © 2018 Rey Cerio. All rights reserved.
//

import Foundation
import RealmSwift

class Items: Object {
    @objc dynamic var name: String?
    @objc dynamic var type: String?
    @objc dynamic var imageFileName: String?
//    @objc dynamic var audioFileName: String?
}
