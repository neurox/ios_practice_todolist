//
//  ViewController.swift
//  MyTodoList
//
//  Created by Juan José Gómez López on 6/3/18.
//  Copyright © 2018 INGOMEZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    let todoList = TodoList()
    
    var selectedItem: String?
    static let MAX_TEXT_SIZE = 40
    
    @IBAction func addButtonPressed(sender: UIButton) {
        print("Agregando un elemento a la lista: \(String(describing: itemTextField.text))")
        todoList.addItem(item: itemTextField.text!)
        tableView.reloadData()
        itemTextField.text = ""
        self.itemTextField?.resignFirstResponder()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = todoList
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Metodos del tableview delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.itemTextField?.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.selectedItem = self.todoList.getItem(index: indexPath.row)
        self.performSegue(withIdentifier: "showItem", sender: self)
        
        /*
        // Alternative to change view without segue
        let detailVC = DetailViewController()
        detailVC.item = self.selectedItem
        self.navigationController?.pushViewController(detailVC, animated: true)
        */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailViewController {
            detailViewController.item = self.selectedItem
        }
    }
    
    //MARK: Metodos del textField delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let tareaString = textField.text as NSString? {
            let updateString = tareaString.replacingCharacters(in: range, with: string)
            return updateString.count <= ViewController.MAX_TEXT_SIZE
        } else {
            return true
        }
    }
}

