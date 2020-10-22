//
//  Like+CoreDataProperties.swift
//  iBottaTest
//
//  Created by Tatsuya Moriguchi on 10/21/20.
//  Copyright © 2020 Tatsuya Moriguchi. All rights reserved.
//
//

import Foundation
import CoreData


extension Like {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Like> {
        return NSFetchRequest<Like>(entityName: "Like")
    }

    @NSManaged public var id: String?
    @NSManaged public var like: Bool

}
