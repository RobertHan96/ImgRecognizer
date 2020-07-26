import UIKit
import Foundation
import Firebase
import Network
    
class MainVC: UIViewController {
    let picker = UIImagePickerController()
    var mLkit = MLkitManager()
    let mornitor = NWPathMonitor()
    let queue = DispatchQueue.global(qos: .background)
    @IBOutlet weak var detectIndicator: UIActivityIndicatorView!
    @IBOutlet weak var detectedImg: UIImageView!
    @IBOutlet weak var resultViewContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstResultLabel: UILabel!
    @IBOutlet weak var secondResultLabel: UILabel!
    @IBOutlet weak var firstConfLabel: UILabel!
    @IBOutlet weak var secondConfLabel: UILabel!
    @IBOutlet weak var firstConfGraph: NSLayoutConstraint!
    @IBOutlet weak var secondConfGraph: NSLayoutConstraint!
    
    override func viewDidLoad() {
        picker.delegate = self
        setupUI()
    }
    
    func setupUI() {
        detectIndicator.stopAnimating()
        resultViewContainer.layer.cornerRadius = 10
        resultViewContainer.isHidden = true
        detectedImg.layer.borderWidth = 1
        detectedImg.layer.borderColor = UIColor.darkGray.cgColor
        detectedImg.layer.cornerRadius = 10
        firstResultLabel.adjustsFontSizeToFitWidth = true
        secondResultLabel.adjustsFontSizeToFitWidth = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    @IBAction func addImg(_ sender: Any) {
        addImageAlertAction()
    }
    
    func detectLabel(){
        detectIndicator.startAnimating()
        if let detectedImg = detectedImg.image {
            mLkit.detectLabels(img: detectedImg) { (labels) in
                labels.sorted(by: {$0.confidence > $1.confidence})
                self.mLkit.logResult(resultArr: labels)
                DispatchQueue.main.async {
                    self.setupResult(resultArr: labels)
                }
            } // detectLandmarks
        } // if let
    } // func
    
    func detectLandmark() {
        detectIndicator.startAnimating()
        if let detectedImg = detectedImg.image {
            mLkit.detectLandmarks(img: detectedImg) { (landmarks) in
                if landmarks.count == 0 {
                    self.titleLabel.text = "일치하는 랜드마크 없음"
                    self.resultViewContainer.isHidden = true
                    self.detectIndicator.stopAnimating()
                } else {
                    self.mLkit.logResult(resultArr: landmarks)
                    self.setupResult(resultArr: landmarks)
                }
            } // detectLandmarks
        } // if let
    } // func
    
    func setupResult(resultArr : [VisionLabel]) {
        self.titleLabel.text = "AI 탐지 결과"
        self.firstResultLabel.text = "\(resultArr[0].name)"
        self.firstConfLabel.text = "\(resultArr[0].confidence.makeConfPoint)"
        self.secondResultLabel.text = "\(resultArr[1].name)"
        self.secondConfLabel.text = "\(resultArr[1].confidence.makeConfPoint)"
        self.resultViewContainer.isHidden = false
        self.detectIndicator.stopAnimating()
        
        UIView.animate(withDuration: 2) {
            let containerWith = self.resultViewContainer.layer.bounds.width
            self.firstConfGraph.constant = containerWith * resultArr[0].confidence.makeConfToConts
            self.secondConfGraph.constant = containerWith * resultArr[1].confidence.makeConfToConts
            self.view.layoutIfNeeded()
        }
    }
}// class

extension MainVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            detectedImg.image = image
            print(info)
         }
        dismiss(animated: true, completion: nil)
        detectUserRequestAction()
     }
}
