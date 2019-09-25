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
    
    var task: [Task] {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        return(try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    var tasks: [Task] = []
    
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
        task.due = due
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
