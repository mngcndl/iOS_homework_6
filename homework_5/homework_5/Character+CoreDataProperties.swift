//
//  Character+CoreDataProperties.swift
//  homework_5
//
//  Created by Liubov on 16.07.2023.
//

import Foundation
import CoreData
import UIKit


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
    }
    @NSManaged public var name: String?
    @NSManaged public var status: String?
    @NSManaged public var species: String?
    @NSManaged public var gender: String?
    @NSManaged public var location: String?
    @NSManaged public var dataID: Int64
    @NSManaged public var image: Data?
}

extension Character : Identifiable {

}
