import UIKit

class NewItemViewController: UIViewController {
    
    @IBOutlet var nameField: UITextField?
    @IBOutlet var caloriesField: UITextField?
    var delegate:AddAnItemDelegate?
    
    init(delegate: AddAnItemDelegate) {
        super.init(nibName: "NewItemViewController", bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func addNewItem() {
        let name = self.nameField!.text
        let calories = Double(self.caloriesField!.text!)
        
        if (name == nil  || calories == nil || self.delegate == nil) {
            return
        }
        
        let item = Item(name: name!, calories: calories!)
        self.delegate!.add(item)
        
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        }
    }
}
