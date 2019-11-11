//
//  MasterViewController.swift
//  Homework3
//
//  Created by Margis on 2019/11/11.
//  Copyright © 2019 Margis. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var objects = [String]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:
            #selector(insertNew2DO(_:)))
        navigationItem.rightBarButtonItem = addButton
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

//    @objc
//    func insertNewObject(_ sender: Any) {
//        objects.insert(NSDate(), at: 0)
//        let indexPath = IndexPath(row: 0, section: 0)
//        tableView.insertRows(at: [indexPath], with: .automatic)
//    }
//
    @objc
    func insertNew2DO(_ sender: Any){
        var toDoTextField: UITextField?
        let alertController = UIAlertController(
          title: "new 2Do",
          message: "Please enter your 2Do",
          preferredStyle: UIAlertController.Style.alert)
        let toDoAction = UIAlertAction(
        title: "OK", style: UIAlertAction.Style.default) {
               (action) -> Void in
                 if let toDo = toDoTextField?.text {
                   print(" toDo = \(toDo)")
                   self.objects.insert(toDo, at: 0)
                   let indexPath = IndexPath(row: 0, section: 0)
                   self.tableView.insertRows(at: [indexPath], with: .automatic)
                 } else {
                   print("No toDo entered")
                 }
        }
        alertController.addTextField {
          (txt2Do) -> Void in
            toDoTextField = txt2Do
            toDoTextField!.placeholder = "<Your 2Do here>"
        }
        alertController.addAction(toDoAction)
        self.present(alertController, animated: true, completion: nil)
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let object = objects[indexPath.row]
        cell.label!.text = ""
        cell.switchButton.setOn(false, animated: false)
        cell.label!.text = object.description
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

