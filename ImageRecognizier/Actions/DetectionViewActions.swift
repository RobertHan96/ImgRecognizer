import Foundation
import UIKit

extension DetectionVC {
    func detectUserRequestAction() {
        let alert =  UIAlertController(title: "이미지 탐지 방법 선택", message: "AI를 통해 확인할 유형을 선택해주세요.", preferredStyle: .actionSheet)
        let detectLabel =  UIAlertAction(title: "이미지 유형 감지", style: .default) { (action) in
            self.detectLabel()
        }
        let detectLandmark =  UIAlertAction(title: "랜드마크 감지", style: .default) { (action) in
            self.detectLandmark()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(detectLabel)
        alert.addAction(detectLandmark)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }
    
    func detectLabel(){
        detectionResultView.detectIndicator.startAnimating()
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
        detectionResultView.detectIndicator.startAnimating()
        if let detectedImg = detectedImg.image {
            mLkit.detectLandmarks(img: detectedImg) { (landmarks) in
                if landmarks.count == 0 {
                    self.detectionResultView.isHidden = true
                    self.detectionResultView.detectIndicator.stopAnimating()
                } else {
                    self.mLkit.logResult(resultArr: landmarks)
                    self.setupResult(resultArr: landmarks)
                }
            } // detectLandmarks
        } // if let
    } // func
    
    func setupResult(resultArr : [VisionLabel]) {
        self.detectionResultView.firstResultLabel.text = "\(resultArr[0].name)"
        self.detectionResultView.firstConfLabel.text = "\(resultArr[0].confidence.makeConfPoint)"
        self.detectionResultView.secondResultLabel.text = "\(resultArr[1].name)"
        self.detectionResultView.secondConfLabel.text = "\(resultArr[1].confidence.makeConfPoint)"
        self.detectionResultView.isHidden = false
        self.detectionResultView.detectIndicator.stopAnimating()
        animDetectResult(resultArr: resultArr)
    }
}
