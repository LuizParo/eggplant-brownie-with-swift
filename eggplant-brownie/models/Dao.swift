import Foundation

class Dao {
    let mealsArchive:String
    let itemsArchive:String
    
    init() {
        let userDirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let dir = userDirs[0]
        
        self.mealsArchive = "\(dir)/eggplant-brownie-meals.data"
        self.itemsArchive = "\(dir)/eggplant-brownie-items.data"
    }
    
    func save(_ meals:Array<Meal>) -> Void {
        NSKeyedArchiver.archiveRootObject(meals, toFile: self.mealsArchive)
    }
    
    func load() -> Array<Meal> {
        if let loadedMeals = NSKeyedUnarchiver.unarchiveObject(withFile: self.mealsArchive) {
            let meals = loadedMeals as! Array<Meal>
            return meals
        }
        
        return []
    }
    
    func save(_ items:Array<Item>) -> Void {
        NSKeyedArchiver.archiveRootObject(items, toFile: self.itemsArchive)
    }
    
    func load() -> Array<Item> {
        if let loadedItems = NSKeyedUnarchiver.unarchiveObject(withFile: self.itemsArchive) {
            let items = loadedItems as! Array<Item>
            return items
        }
        return []
    }
}
