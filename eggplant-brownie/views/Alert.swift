import Foundation
import UIKit

class Alert {
    
    let controller:UIViewController
    
    init(controller:UIViewController) {
        self.controller = controller
    }
    
    func show(title:String = "Sorry", message:String = "Unexpected error") {
        let ok = UIAlertAction(title: "Understood", style: UIAlertActionStyle.cancel, handler: nil)
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(ok)
        
        self.controller.present(alert, animated: true, completion: nil)
    }
}
