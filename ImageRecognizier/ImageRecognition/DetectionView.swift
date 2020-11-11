import Foundation
import UIKit
import Material

extension DetectionVC {
    func setupUI() {
        self.navigationController?.setupNavigationViewUI(currentNavi: self.navigationController)
        let shareDetectionResultsBtn = UIBarButtonItem(image: .resultShareButtomImage, style: .plain, target: self, action: #selector(shareDetectionResults))
        self.navigationItem.rightBarButtonItems = [shareDetectionResultsBtn]
        detectionInfromText.adjustsFontSizeToFitWidth = true
        detectionInfromText.text = "detectionInformText".localized
        detectedImg.layer.borderWidth = 1
        detectedImg.layer.borderColor = UIColor.darkGray.cgColor
        detectedImg.layer.cornerRadius = 10
        self.detectIndicator.startAnimating()
        
        detectionResultView.firstConfGraphBar.layer.cornerRadius = 10
        detectionResultView.secondConfGraphBar.layer.cornerRadius = 10
        detectionResultView.isHidden = true
        detectionResultView.firstResultLabel.adjustsFontSizeToFitWidth = true
        detectionResultView.secondResultLabel.adjustsFontSizeToFitWidth = true
    }

    func animDetectResult(resultArr : [VisionLabel]) {
        UIView.animate(withDuration: 2) {
            let containerWith = self.detectionResultView.layer.bounds.width
            self.detectionResultView.firstConfGraphBarWidth.constant = containerWith * resultArr[0].confidence.makeConfToConts
            self.detectionResultView.secondConfGraphBarWidth.constant = containerWith * resultArr[1].confidence.makeConfToConts
            self.detectIndicator.stopAnimating()
            self.detectIndicator.isHidden = true
            self.view.layoutIfNeeded()
        }
    }
}
