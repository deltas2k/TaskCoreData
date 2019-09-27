//
//  TaskDetailTableViewController.swift
//  TaskCoreData
//
//  Created by Matthew O'Connor on 9/25/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    var tasks: Task? {
        didSet {
            updateViews()
        }
    }
    
    var dueDateValue: Date?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        dueTextField.inputView = dueDatePicker
    }
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        self.dueTextField.text = sender.date.stringValue()
        self.dueDateValue = sender.date
    }
    
    @IBAction func userTappedView(_ sender: Any) {
        self.dueTextField.resignFirstResponder()
        self.nameTextField.resignFirstResponder()
        self.notesTextView.resignFirstResponder()   
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text,
            !name.isEmpty,
            let due = dueDateValue,
            let notes = notesTextView.text
            else {return}
        if let task = tasks {
            TaskController.shared.updateTask(task: task, name: name, notes: notes, due: due)
        } else {
            TaskController.shared.createTask(withName: name, notes: notes, due: due)
        }
        navigationController?.popViewController(animated: true)
    }
    
   private func updateViews() {
        guard let task = tasks, isViewLoaded else {return}
        
    nameTextField.text = task.name
        dueTextField.text = (task.due as Date?)?.stringValue()
        notesTextView.text = task.notes
    }
    
    
    // MARK: - Table view data source
    


}
