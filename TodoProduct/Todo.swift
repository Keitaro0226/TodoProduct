//
//  Todo.swift
//  TodoProduct
//
//  Created by Keitaro Kawahara on 2022/09/05.
//

import Foundation
import RealmSwift

class Item: Object {
    
   
    @objc dynamic var title: String = ""
    @objc dynamic var detail: String = ""
    @objc dynamic var date: String = ""
   
   
}


