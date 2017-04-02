import Foundation

class Meal : NSObject, NSCoding {
    let name:String
    let happiness:Int
    let items:Array<Item>
    
    init(name:String, happiness:Int, items:Array<Item> = []) {
        self.name = name
        self.happiness = happiness
        self.items = items
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.happiness = aDecoder.decodeInteger(forKey: "happiness")
        self.items = aDecoder.decodeObject(forKey : "items") as! Array
    }
    
    func allCalories() -> Double {
        var total:Double = 0.0
        
        for item in self.items {
            total += item.calories
        }
        
        return total
    }
    
    func details() -> String {
        var message:String = "Happiness: \(self.happiness)"
        
        for item in self.items {
            message += "\n \(item.name) - calories: \(item.calories)"
        }
        
        return message;
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.happiness, forKey: "happiness")
        aCoder.encode(self.items, forKey: "items")
    }
}
