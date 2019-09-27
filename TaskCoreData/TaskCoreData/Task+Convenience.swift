//
//  Task+Convenience.swift
//  TaskCoreData
//
//  Created by Matthew O'Connor on 9/25/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    convenience init(name: String, notes: String? = nil, due: Date? = nil, isComplete: Bool = false, moc:NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: moc)
        self.name = name
        self.notes = notes
        self.due = due as Date?
        self.isComplete = isComplete
    }
}
