import UIKit
import Firebase
import Network

class MainVC: UIViewController {
    @IBOutlet weak var detectedImg: UIImageView!
    @IBOutlet weak var infromText: UILabel!
    let picker = UIImagePickerController()

    override func viewDidLoad() {
        setupUI()
        picker.delegate = self
    }
    
    @IBAction func addImg(_ sender: Any) {
        addImageAlertAction()
    }
}

extension MainVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            detectedImg.image = image
            let detectedImage = image.jpegData(compressionQuality: 0.1)        // 10분의 1 품질로 축소
            UserDefaults.standard.set(detectedImage, forKey: "detectedImage")
            UserDefaults.standard.synchronize()
         }
        dismiss(animated: true, completion: nil)
        guard let filterVC = self.storyboard?.instantiateViewController(withIdentifier: "filterVC") else { return }
        self.navigationController?.pushViewController(filterVC, animated: true)
     }
}
