//
//  EntryViewController.swift
//  TodoList
//
//  Created by Hannah Kovinsky on 9/30/21.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var field: UITextField!
    
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))//selector what happens when clicked
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        
        return true
    }
    @objc func saveTask(){
        
        guard let text = field.text, !text.isEmpty else{//if cases true then return
            return
        }
        guard let count = UserDefaults().value(forKey: "count") as? Int else{//make sure can increment count and not come back as nothing
            return
        }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        
        UserDefaults().set(text, forKey: "task_\(newCount)")//key unique every time save task
        
        update?()//if update function exists, lets call it
        
        navigationController?.popViewController(animated: true)
    }
}
