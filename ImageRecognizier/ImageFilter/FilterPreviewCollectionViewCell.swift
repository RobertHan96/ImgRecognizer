import UIKit

class FilterPreviewCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var filterName: UILabel!
    @IBOutlet weak var filterImgPreView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func display(image : UIImage, filterName : String) {
       let orientation = image.imageOrientation
        let ciContext = CIContext(options: nil)
        let coreImage = CIImage(image: image)
        if let filter = CIFilter(name: filterName) {
            filter.setDefaults()
            filter.setValue(coreImage, forKey: kCIInputImageKey)
            if let filteredImageData = filter.value(forKey: kCIOutputImageKey) as? CIImage,
                let filteredImageRef = ciContext.createCGImage(filteredImageData, from: filteredImageData.extent) {
               let image = UIImage(cgImage: filteredImageRef, scale: 1.0, orientation: orientation)
               filterImgPreView.image = image
            }
        }
    }
    
    func setupUI() {
        self.filterName.adjustsFontSizeToFitWidth = true
    }
}
