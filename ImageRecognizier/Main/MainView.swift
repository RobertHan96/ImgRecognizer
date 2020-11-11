import UIKit
import Material

extension MainVC {
    func setupUI() {
        self.navigationController?.setupNavigationViewUI(currentNavi: self.navigationController)
        let analayzeImage = UIBarButtonItem(image: UIImage.photoCameraButtonImage, style: .plain, target: self, action: #selector(open))
        self.navigationItem.rightBarButtonItems = [analayzeImage]
        detectedImg.layer.borderWidth = 1
        detectedImg.layer.borderColor = UIColor.darkGray.cgColor
        detectedImg.layer.cornerRadius = 10
        infromText.text = "mainViewInformText".localized
        infromText.adjustsFontSizeToFitWidth = true
        
    }
    
    func popupError() {
        let storyBoard = UIStoryboard.init(name: "NetwrokWaringPopup", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "netwrokWaring")
        popupVC.modalPresentationStyle = .overCurrentContext
        self.present(popupVC, animated: true, completion: nil)
    }
}
