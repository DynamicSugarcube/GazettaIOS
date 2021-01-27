//
//  DatabaseStack.swift
//  GazettaIOS
//
//  Created by Vsevolod Sharov on 27.01.2021.
//

import CoreData
import Foundation

class DatabaseStack {
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
}
