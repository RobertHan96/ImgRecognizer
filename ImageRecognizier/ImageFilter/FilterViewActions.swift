import UIKit
import Photos

extension FilterVC {
    @objc func analayzeImg() {
        guard let detectionVC = self.storyboard?.instantiateViewController(withIdentifier: "DetectionVC") else { return }
        self.navigationController?.pushViewController(detectionVC, animated: true)
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

}
