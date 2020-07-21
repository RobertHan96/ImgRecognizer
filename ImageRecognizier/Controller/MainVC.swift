import UIKit
import Foundation
import Firebase

class MainVC: BaseViewController {
    let picker = UIImagePickerController()
    var myMLkit = MLkitManager()
    @IBOutlet weak var detectedImg: UIImageView!
    @IBOutlet weak var resultViewContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstResultLabel: UILabel!
    @IBOutlet weak var secondResultLabel: UILabel!
    
    override func viewDidLoad() {
        setValues()
        setupUI()
    }
    
    override func setupUI() {
        resultViewContainer.layer.cornerRadius = 10
        detectedImg.layer.borderWidth = 1
        detectedImg.layer.borderColor = UIColor.darkGray.cgColor
        detectedImg.layer.cornerRadius = 10
    }
    
    override func setValues() {
        picker.delegate = self
        if let detectedImg = detectedImg.image {
            MLkitManager.detectLabels(img: detectedImg) { (label) in
                print("[Log]",label.first)
//                self.titleLabel.text = label.name
//                self.firstResultLabel.text = "결과 : \(label.name)"
//                self.secondResultLabel.text = "매칭률 : \(label.confidence)"
            }
            MLkitManager.detectLandmarks(img: detectedImg) { (landmark) in
                print("[Log]", landmark.first)
            }
        }
    }
    
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
    
    @IBAction func addImg(_ sender: Any) {
        let alert =  UIAlertController(title: "이미지 선택", message: "갤러리 또는 사진을 촬영해 인공지능 감지를 위한 이미지를 추가해주세요.", preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary()
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
    
}// class

extension MainVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
        detectedImg.image = image
        setValues()
        print(info)
     }
     dismiss(animated: true, completion: nil)
     }
}// extension
