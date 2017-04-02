import Foundation
import UIKit

class RemoveMealController {
    
    let controller:UIViewController
    
    init(controller:UIViewController) {
        self.controller = controller
    }
    
    func show(_ meal:Meal, handler: @escaping (UIAlertAction) -> Void) -> Void {
        let cancel = UIAlertAction(title: "Cencel", style: UIAlertActionStyle.cancel, handler: nil)
        let remove = UIAlertAction(title: "Remove", style: UIAlertActionStyle.destructive, handler: handler)
        
        let details = UIAlertController(title: meal.name, message: meal.details(), preferredStyle: UIAlertControllerStyle.alert)
        details.addAction(cancel)
        details.addAction(remove)
        
        self.controller.present(details, animated: true, completion: nil)
    }
}
