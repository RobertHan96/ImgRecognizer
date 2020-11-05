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
                print("인터넷 연결 확인, 사물인식 API 호출")
//                guard let detectionVC = self.storyboard?.instantiateViewController(withIdentifier: "DetectionVC") else { return }
//                self.navigationController?.pushViewController(detectionVC, animated: true)
            } else {
                print("인터넷 연결 없음")
//                self.view.makeToast("네트워크 연결 상태를 확인해주세요.", duration: 3.0, position: .center)
//                self.showNetworkErrorPopup()
                
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
        print("image is saved")
    }
    
    func savePhotoLibrary(image: UIImage) {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                }, completionHandler: { (_, error) in
                 
                })
            } else {
                print("error to save photo library")
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
