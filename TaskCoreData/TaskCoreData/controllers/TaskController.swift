//
//  TaskController.swift
//  TaskCoreData
//
//  Created by Matthew O'Connor on 9/25/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    static let shared = TaskController()
    
    let fetchedResultsController: NSFetchedResultsController<Task>
    init() {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let isCompleteSort = NSSortDescriptor(key: "isComplete", ascending: false)
        let dueSort = NSSortDescriptor(key: "due", ascending: false)
        fetchRequest.sortDescriptors = [isCompleteSort, dueSort]
        let resultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: "isComplete", cacheName: nil)
        fetchedResultsController = resultController
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)") 
        }
    }
    
//    var tasks: [Task] = [] //mockdata
    
//    init () { //old way of doing it
//        tasks = fetchTasks()
//    }
//    private func fetchTasks() -> [Task] {
//        let request: NSFetchRequest<Task> = Task.fetchRequest()
//        return(try? CoreDataStack.context.fetch(request)) ?? []
//    }
    
    func toggleCompleteFor(task: Task){
        task.isComplete = !task.isComplete
        saveToPersistStore()
    }
    
    func createTask(withName name: String, notes: String?, due: Date?) {
        let _ = Task(name: name, notes: notes, due: due)
        saveToPersistStore()
//        tasks = fetchTasks()
    }
    
    func updateTask(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due as Date?
        saveToPersistStore()
//        tasks = fetchTasks()
    }
    
    func deleteTask(task: Task) {
        CoreDataStack.context.delete(task)
        saveToPersistStore()
//        tasks = fetchTasks()
    }
    
    func saveToPersistStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
    }
}


//let mockTask: [Task] = {
//    let task1 = Task(name: "Get stuff from store", notes: "remember all the things", due: Date(timeIntervalSinceNow: 5000), isComplete: false)
//    let task2 = Task(name: "walk the cat", notes: "will probably be angry", due: Date(timeIntervalSinceNow: 6000), isComplete: false)
//
//    return [task1, task2]
//}()


