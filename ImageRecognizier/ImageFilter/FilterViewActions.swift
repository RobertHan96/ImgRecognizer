import UIKit
import Photos
import Network
import Toast_Swift

extension FilterVC {
    @objc func analayzeImg() {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue.global(qos: .background)
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("logHeader".localized, "인터넷 연결 확인, 사물인식 API 호출")
                DispatchQueue.main.async {
                    guard let detectionVC = self.storyboard?.instantiateViewController(withIdentifier: "DetectionVC") else { return }
                    self.navigationController?.pushViewController(detectionVC, animated: true)
                }
            } else {
                print("logHeader".localized, "인터넷 연결 실패")
                DispatchQueue.main.async {
                    self.view.makeToast("netwrokErrorMessage".localized, duration: 3.0, position: .center)
                }
                
            }
        }
    }
    
    @objc func dowloadImg() {
        imageSave()
    }
    
    func imageSave() {
        if let img = filterdImage.image {
            savePhotoLibrary(image: img)
        }
        print("logHeader".localized, "imageSavedNotiText".localized)
        self.view.makeToast("imageSavedNotiText".localized, duration : 3, position: .center)
    }
    
    func savePhotoLibrary(image: UIImage) {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                }, completionHandler: { (_, error) in
                 
                })
            } else {
                print("logHeader".localized, "Can't save image to photo library")
            }
        }
    }
    
    func showNetworkErrorPopup() {
        DispatchQueue.main.async {
        let storyBoard = UIStoryboard.init(name: "NetwrokWaringPopup", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "netwrokWaring")
        popupVC.modalPresentationStyle = .overCurrentContext
       
            self.present(popupVC, animated: true, completion: nil)
        }
    }
    
}
