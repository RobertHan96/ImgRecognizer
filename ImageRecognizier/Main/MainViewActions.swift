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
                print("[Log] Camera not available")
        }
    }
    
    @objc func open() {
        addImageAlertAction()
        //        guard let filterVC = self.storyboard?.instantiateViewController(withIdentifier: "filterVC") else { return }
        //        self.navigationController?.pushViewController(filterVC, animated: true)
    }
    
    func addImageAlertAction() {
        let alert =  UIAlertController(title: "이미지 선택", message: "갤러리 또는 사진을 촬영해 인공지능 감지를 위한 이미지를 추가해주세요.", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in
            self.openLibrary()
        }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            self.openCamera()
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)

    }

}
