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
}
