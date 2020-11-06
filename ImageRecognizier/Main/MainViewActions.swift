import UIKit

extension MainVC {
    func openLibrary(){
      picker.sourceType = .photoLibrary
      present(picker, animated: false, completion: nil)
    }

    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            present(picker, animated: false, completion: nil)
            }else{
            print("logHeader".localized, "Camera isn't ready")
        }
    }
    
    @objc func open() {
        addImageAlertAction()
    }
    
    func addImageAlertAction() {
        let alert =  UIAlertController(title: "addImageAlertTitle".localized, message: "addImageAlertTitleDesc".localized, preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "addImageAlertLibraryButtonTitle".localized, style: .default) { (action) in
            self.openLibrary()
        }
        let camera =  UIAlertAction(title: "addImageAlertCameraButtonTitle".localized, style: .default) { (action) in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "alertCancleButtonTitle".localized, style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)

    }

}
