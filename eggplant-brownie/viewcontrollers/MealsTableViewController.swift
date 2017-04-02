import UIKit

class MealsTableViewController : UITableViewController, AddMealDelegate {
    var meals:Array<Meal> = Array<Meal>()
    
    func add(_ meal:Meal) {
        self.meals.append(meal)
        
        Dao().save(self.meals)
        
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        self.meals = Dao().load()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addMeal") {
            let view:ViewController = segue.destination as! ViewController
            view.delegate = self
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row:Int = indexPath.row
        let meal:Meal = self.meals[row]
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(showDetails))
        
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.textLabel!.text = meal.name
        cell.addGestureRecognizer(longPressRecognizer)
        
        return cell
    }
    
    func showDetails(recognizer: UILongPressGestureRecognizer) -> Void {
        if(recognizer.state == UIGestureRecognizerState.began) {
            let cell:UITableViewCell = recognizer.view as! UITableViewCell
            
            if let indexPath = self.tableView.indexPath(for: cell) {
                let row = indexPath.row
                let meal = self.meals[row]
                
                func removeSelected(action:UIAlertAction) {
                    
                }
                
                RemoveMealController(controller: self).show(meal, handler: { action in
                    self.meals.remove(at: row)
                    self.tableView.reloadData()
                })
            }
        }
    }
}
