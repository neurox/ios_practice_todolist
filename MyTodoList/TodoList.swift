//
//  TodoList.swift
//  MyTodoList
//
//  Created by Alonso Manilla on 6/5/18.
//  Copyright © 2018 INGOMEZ. All rights reserved.
//

import UIKit

class TodoList: NSObject {
    
    var items: [String] = []
    
    override init() {
        super.init()
        loadItems()
    }
    
    private let fileURL: URL = {
        let fileManager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = fileManager.first!
        print("El path es: \(documentDirectoryURL)")
        
        return documentDirectoryURL.appendingPathComponent("todo.list")
    }()
    
    func addItem(item: String) {
        items.append(item)
        saveItems()
    }
    
    func saveItems() {
        let itemsArray = items as NSArray
        
        if itemsArray.write(to: self.fileURL, atomically: true) {
            print("Guardado")
        } else {
            print("No Guardado")
        }
    }
    
    func loadItems() {
        if let itemsArray = NSArray(contentsOf: self.fileURL) as? [String] {
            self.items = itemsArray
        }
    }
    
    func getItem(index: Int) -> String {
        return items[index]
    }
    
}

extension TodoList: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        
        cell.textLabel!.text = item
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
        saveItems()
        tableView.beginUpdates()
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        tableView.endUpdates()
    }
    
}
