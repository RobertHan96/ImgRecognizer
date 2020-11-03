
import UIKit

class DetectionVC: UIViewController {
    @IBOutlet weak var detectionResultView: DetectionResultView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}
