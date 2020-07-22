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
        resultViewContainer.isHidden = true
        detectedImg.layer.borderWidth = 1
        detectedImg.layer.borderColor = UIColor.darkGray.cgColor
        detectedImg.layer.cornerRadius = 10
    }
    
    override func setValues() {
        picker.delegate = self

            

    }
    
    func detectLabel(){
        if let detectedImg = detectedImg.image {
            resultViewContainer.isHidden = false
            MLkitManager.detectLabels(img: detectedImg) { (labels) in
                labels.sorted(by: {$0.confidence > $1.confidence})
                
                for label in labels {
                    print("[Log] 이미지 레이블 탐지 결과")
                    print("[Log]",label)
                }
                
                self.titleLabel.text = "인공지능 이미지 탐지 결과"
                self.firstResultLabel.text = "\(labels[0].name)-\(labels[0].confidence)"
                self.secondResultLabel.text = "\(labels[1].name)-\(labels[1].confidence)"
            }
        }
    }
    
    func detectLandmark() {
        if let detectedImg = detectedImg.image {
            resultViewContainer.isHidden = false
            MLkitManager.detectLandmarks(img: detectedImg) { (landmarks) in
                let firstResult = landmarks.first
                let secondResult = landmarks[1]
                self.titleLabel.text = "랜드마크 여부 검사 결과"
                self.firstResultLabel.text = "\(firstResult!.name)-\(firstResult?.confidence)"
                self.secondResultLabel.text = "\(secondResult.name)-\(secondResult.confidence)"
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
    
    func detectUserRequest() {
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
    
}// class

extension MainVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            detectedImg.image = image
            setValues()
            print(info)
         }
         dismiss(animated: true, completion: nil)
        detectUserRequest()
         }
}
