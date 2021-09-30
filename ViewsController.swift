//
//  ViewController.swift
//  TodoList
//
//  Created by Hannah Kovinsky on 9/30/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    var numbers = ["One","Two","Three","Four","Five","Six","Seven","Eight","Nine","Ten"]
    var tasks = [String]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        //setup
        if !UserDefaults().bool(forKey: "setup"){//saving user defualts
            UserDefaults().set(true, forKey: "setup")//only come in once
            UserDefaults().set(0, forKey: "count")//count is number of taks we have
        }
        updateTasks()
    }
    
    func updateTasks(){
        
        tasks.removeAll()//no duplicates
        guard let count = UserDefaults().value(forKey: "count") as? Int else{
            return
        }
        for x in 0..<count{//for loop to iterate through 0 to count
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String{//if task not empty add to tasks array
                tasks.append(task)
            }
            
        }
        tableView.reloadData()
        
    }
    
    @IBAction func didTapAdd(){
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async{//prioritize updating tasks by calling function
                self.updateTasks()//self bc call function in class
            }
        }
        navigationController?.pushViewController(vc, animated: true)
        
        
    }

}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
        vc.title = "New Task"
        vc.task = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int)->Int{
        return tasks.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for:indexPath)
            cell.textLabel?.text = tasks[indexPath.row]
            return cell
    }

}
extension ViewController{
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == UITableViewCell.EditingStyle.delete {
        tasks.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
}
}
