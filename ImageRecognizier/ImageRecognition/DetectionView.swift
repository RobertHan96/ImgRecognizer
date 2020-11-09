import Foundation
import UIKit
import Material

extension DetectionVC {
    func setupUI() {
        self.navigationController?.setupNavigationViewUI(currentNavi: self.navigationController)
        let btnResultShare = Icon.icon("cm_share_white")
        let shareDetectionResultsBtn = UIBarButtonItem(image: btnResultShare, style: .plain, target: self, action: #selector(shareDetectionResults))
        
        self.navigationItem.rightBarButtonItems = [shareDetectionResultsBtn]

        self.detectIndicator.startAnimating()
        detectionResultView.layer.cornerRadius = 10
        detectionResultView.isHidden = true
        detectionResultView.firstResultLabel.adjustsFontSizeToFitWidth = true
        detectionResultView.secondResultLabel.adjustsFontSizeToFitWidth = true
        detectedImg.layer.borderWidth = 1
        detectedImg.layer.borderColor = UIColor.darkGray.cgColor
        detectedImg.layer.cornerRadius = 10
        
        detectionInfromText.adjustsFontSizeToFitWidth = true
        detectionInfromText.text = "detectionInformText".localized
    }

    func animDetectResult(resultArr : [VisionLabel]) {
        UIView.animate(withDuration: 2) {
            let containerWith = self.detectionResultView.layer.bounds.width
            self.detectionResultView.firstConfGraph.constant = containerWith * resultArr[0].confidence.makeConfToConts
            self.detectionResultView.secondConfGraph.constant = containerWith * resultArr[1].confidence.makeConfToConts
            self.detectIndicator.stopAnimating()
            self.detectIndicator.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
}
