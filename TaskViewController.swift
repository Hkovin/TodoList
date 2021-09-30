//
//  TaskViewController.swift
//  TodoList
//
//  Created by Hannah Kovinsky on 9/30/21.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    var task: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = task
    }

}
