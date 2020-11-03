
import UIKit

class DetectionVC: UIViewController {
    @IBOutlet weak var detectionResultView: DetectionResultView!
    @IBOutlet weak var detectedImg: UIImageView!
    var mLkit = MLkitManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        detectUserRequestAction()
    }
}
