import UIKit
import Photos


class FilterVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var buttonGuidanceLabel: UILabel!
    @IBOutlet weak var filterdImage: UIImageView!
    @IBOutlet weak var filterPreviewCollectionView: UICollectionView!
    var originImage : UIImage?
    let ciFilterNames : [String] = [
        "CIColorInvert", "CIColorMonochrome","CIColorPosterize",
        "CIFalseColor", "CIMaskToAlpha", "CIMaximumComponent", "CIMinimumComponent",
        "CIPhotoEffectChrome", "CIPhotoEffectFade", "CIPhotoEffectInstant",
        "CIPhotoEffectMono", "CIPhotoEffectNoir", "CIPhotoEffectProcess",
        "CIPhotoEffectTonal", "CIPhotoEffectTransfer", "CISepiaTone"
    ]
    
    let filterNamesForDisplay : [ String ] = [
        "InvertFilter".localized, "MonochromeFilter".localized, "PosterizeFilter".localized,
        "FalseColorFilter".localized, "MaskToAlphaFilter".localized, "MaximumComponentFilter".localized,
        "MinimumComponentFilter".localized, "ChromeFilter".localized, "FadeFilter".localized,
        "InstantFilter".localized, "MonoFilter".localized, "NoirFilter".localized, "ProcessFilter".localized,
        "TonalFilter".localized, "TransferFilter".localized, "SepiaFilter".localized
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
       if let imgData = UserDefaults.standard.object(forKey: "detectedImage") as? NSData
       {
           if let image = UIImage(data: imgData as Data)
           {
                self.filterdImage.image = image
                self.originImage = image
           }
       }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("logHeader".localized, self.ciFilterNames[indexPath.row], "필터 효과 적용")
        if let img = originImage {
            DispatchQueue.main.async {
                self.displayFilterdImage(image: img, filterName: self.ciFilterNames[indexPath.row])
               self.view.layoutIfNeeded()
           }
       }
   }
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return ciFilterNames.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let filterPreViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterPreViewCell", for: indexPath) as? FilterPreviewCollectionViewCell
        else { return UICollectionViewCell() }
        filterPreViewCell.filterName.text = filterNamesForDisplay[indexPath.row]
        let exampleImage = UIImage(named: "example")

    if let img = filterdImage.image {
            filterPreViewCell.display(image: img, filterName: ciFilterNames[indexPath.row])
        } else {
            filterPreViewCell.display(image: exampleImage!, filterName: ciFilterNames[indexPath.row])
        }
    
       return filterPreViewCell
   }

   private func displayFilterdImage(image : UIImage, filterName : String) {
      let orientation = image.imageOrientation
       let ciContext = CIContext(options: nil)
       let coreImage = CIImage(image: image)
       if let filter = CIFilter(name: filterName) {
           filter.setDefaults()
           filter.setValue(coreImage, forKey: kCIInputImageKey)
           if let filteredImageData = filter.value(forKey: kCIOutputImageKey) as? CIImage,
               let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent) {
               let image = UIImage(cgImage: filteredImageRef, scale: 1.0, orientation: orientation)
               filterdImage.image = image
           }
       }
   }

}
