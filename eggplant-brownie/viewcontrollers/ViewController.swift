//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Luiz Guilherme Paro on 27/01/17.
//  Copyright © 2017 Luiz Guilherme Paro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddAnItemDelegate {
    
    @IBOutlet var nameField: UITextField?;
    @IBOutlet var happinessField: UITextField?;
    var delegate:AddMealDelegate?
    var selectedItems = Array<Item>()
    @IBOutlet var tableView:UITableView?
    
    var items:Array<Item> = [Item(name: "Eggplant", calories: 10),
                             Item(name: "Brownie", calories: 10),
                             Item(name: "Zucchini", calories: 10),
                             Item(name: "Muffin", calories: 10),
                             Item(name: "Coconut oil", calories: 500),
                             Item(name: "Chocolat frosting", calories: 1000),
                             Item(name: "Chocolate chip", calories: 1000)]
    
    func add(_ item: Item) {
        self.items.append(item)
        
        Dao().save(self.items)
        
        if let table = self.tableView {
            table.reloadData()
        } else {
            Alert(controller: self).show(title: "Sorry", message: "Unable to refresh the table with the new item")
        }
    }
    
    override func viewDidLoad() {
        let newItemButton = UIBarButtonItem(title: "New Item", style: UIBarButtonItemStyle.plain, target: self, action: #selector(showNewItem))
        self.navigationItem.rightBarButtonItem = newItemButton
        
        self.items = Dao().load()
    }
    
    func showNewItem() {
        let newItem = NewItemViewController(delegate : self)
        
        if let navigation = self.navigationController {
            navigation.pushViewController(newItem, animated: true)
        } else {
            Alert(controller: self).show(title: "Sorry")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item:Item = self.items[indexPath.row]
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if(cell.accessoryType == UITableViewCellAccessoryType.none) {
                cell.accessoryType = UITableViewCellAccessoryType.checkmark
                
                let item = self.items[indexPath.row]
                self.selectedItems.append(item)
            } else {
                cell.accessoryType = UITableViewCellAccessoryType.none
                
                let item = self.items[indexPath.row]
                if let position = self.selectedItems.index(of: item) {
                    self.selectedItems.remove(at: position)
                } else {
                    Alert(controller: self).show(title: "Sorry")
                }
            }
        } else {
            Alert(controller: self).show(title: "Sorry")
        }
    }
    
    func convertToInt(_ text: String?) -> Int? {
        if let number = text {
            return Int(number)
        }
        
        return nil
    }
    
    func getMealFromForm() -> Meal? {
        if let name = self.nameField?.text {
            if let happiness = self.convertToInt(self.happinessField?.text) {
                let meal:Meal = Meal(name: name, happiness: happiness, items: selectedItems)
                
                print("eaten \(meal.name) with happiness \(meal.happiness) with \(meal.items)");
                
                return meal
            }
        }
 
        return nil
    }
    
    @IBAction func add() {
        if let meal:Meal = self.getMealFromForm() {
            if let meals = self.delegate {
                meals.add(meal)
                
                if let navigation = self.navigationController {
                    navigation.popViewController(animated: true)
                    return
                }
                
                Alert(controller: self).show(message: "Unable to return to the previous screen, but the meal was added")
            }
        }
        
        Alert(controller: self).show()
    }
}
