import UIKit

extension FilterVC {
    @objc func addTapped() {
        guard let detectionVC = self.storyboard?.instantiateViewController(withIdentifier: "DetectionVC") else { return }
        self.navigationController?.pushViewController(detectionVC, animated: true)
    }
    
    @objc func playTapped() {
        print("이미지 저장 기능 추후 구현 예정")
    }
    
}
