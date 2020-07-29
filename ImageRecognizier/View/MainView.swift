import UIKit

extension MainVC {
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
    
    func animDetectResult(resultArr : [VisionLabel]) {
        UIView.animate(withDuration: 2) {
            let containerWith = self.resultViewContainer.layer.bounds.width
            self.firstConfGraph.constant = containerWith * resultArr[0].confidence.makeConfToConts
            self.secondConfGraph.constant = containerWith * resultArr[1].confidence.makeConfToConts
            self.view.layoutIfNeeded()
        }
    }
    
    func popupError() {
        let storyBoard = UIStoryboard.init(name: "NetwrokWaringPopup", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "netwrokWaring")
        popupVC.modalPresentationStyle = .overCurrentContext
        self.present(popupVC, animated: true, completion: nil)
    }
}
