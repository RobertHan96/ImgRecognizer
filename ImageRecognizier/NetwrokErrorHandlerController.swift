import UIKit
import Network

class NetwrokWaringPopup: BaseViewController {
    @IBOutlet weak var netwrokStatusLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func doneBtn(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}


