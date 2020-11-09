
import UIKit

class DetectionVC: UIViewController {
    @IBOutlet weak var detectionResultView: DetectionResultView!
    @IBOutlet weak var detectedImg: UIImageView!
    @IBOutlet weak var detectIndicator: UIActivityIndicatorView!
    @IBOutlet weak var detectionInfromText: UILabel!
    
    var mLkit = MLkitManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let imgData = UserDefaults.standard.object(forKey: "detectedImage") as? NSData
        {
            if let image = UIImage(data: imgData as Data)
            {
                 self.detectedImg.image = image
            }
        }
        
        do {
            self.detectUserRequestAction()
        } catch {
            print("logHeader".localized, error.localizedDescription)
        }
    }
}
