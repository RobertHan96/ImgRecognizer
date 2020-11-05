import Foundation
import UIKit

extension DetectionVC {
    func setupUI() {
        self.detectIndicator.startAnimating()
        detectionResultView.layer.cornerRadius = 10
        detectionResultView.isHidden = true
        detectionResultView.firstResultLabel.adjustsFontSizeToFitWidth = true
        detectionResultView.secondResultLabel.adjustsFontSizeToFitWidth = true
        detectedImg.layer.borderWidth = 1
        detectedImg.layer.borderColor = UIColor.darkGray.cgColor
        detectedImg.layer.cornerRadius = 10
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
