import Foundation
import UIKit

extension DetectionVC {
    func detectUserRequestAction() {
        let alert =  UIAlertController(title: "chooseDetectWayAlertTitle".localized,
                                       message: "chooseDetectWayAlertDesc".localized, preferredStyle: .actionSheet)
        let detectLabel =  UIAlertAction(title: "LabelDetectText".localized, style: .default) { (action) in
            self.detectLabel()
        }
        let detectLandmark =  UIAlertAction(title: "LandmarkDetectText".localized, style: .default) { (action) in
            self.detectLandmark()
        }
        let cancel = UIAlertAction(title: "alertCancleButtonTitle".localized, style: .cancel, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        })
        alert.addAction(detectLabel)
        alert.addAction(detectLandmark)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }
    
    func detectLabel(){
        if let detectedImg = detectedImg.image {
            mLkit.detectLabels(img: detectedImg) { (labels) in
                if labels.count == 0 {
                    self.detectionResultView.isHidden = true
                    self.detectIndicator.stopAnimating()
                    self.view.makeToast(DetectionResultError.invalidInputImage.rawValue, duration : 3, position: .center)
                    print("logHeader".localized, "이미지 감지 불가")
                } else {
                    labels.sorted(by: {$0.confidence > $1.confidence})
                    self.mLkit.logResult(resultArr: labels)
                    DispatchQueue.main.async {
                        self.setupResult(resultArr: labels)
                    }
                }
            } // detectLabel
        } else {
            self.view.makeToast(DetectionResultError.invalidInputImage.rawValue, duration : 3, position: .center)
            print("logHeader".localized, "이미지 감지 불가")
        }
    } // func
    
    func detectLandmark() {
        if let detectedImg = detectedImg.image {
            mLkit.detectLandmarks(img: detectedImg) { (landmarks) in
                if landmarks.count == 0 {
                    self.detectionResultView.isHidden = true
                    self.detectIndicator.stopAnimating()
                    self.view.makeToast(DetectionResultError.invalidLandmark.rawValue, duration : 3, position: .center)
                    print("logHeader".localized, "랜드마크 감지 불가")
                } else {
                    self.mLkit.logResult(resultArr: landmarks)
                    self.setupResult(resultArr: landmarks)
                }
            } // detectLandmarks
        } else {
            self.view.makeToast(DetectionResultError.invalidInputImage.rawValue, duration : 3, position: .center)
            print("logHeader".localized, "이미지 감지 불가")
        }
    } // func
    
    func setupResult(resultArr : [VisionLabel]) {
        self.detectIndicator.stopAnimating()
        self.detectionResultView.firstResultLabel.text = "\(resultArr[0].name)"
        self.detectionResultView.firstConfLabel.text = "\(resultArr[0].confidence.makeConfPoint)"
        self.detectionResultView.secondResultLabel.text = "\(resultArr[1].name)"
        self.detectionResultView.secondConfLabel.text = "\(resultArr[1].confidence.makeConfPoint)"
        self.detectionResultView.isHidden = false
        animDetectResult(resultArr: resultArr)
    }
    
    @objc func shareDetectionResults() {
        let image = self.view.captureScreenToImage()
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]

        self.present(activityViewController, animated: true, completion: nil)
    }
}
